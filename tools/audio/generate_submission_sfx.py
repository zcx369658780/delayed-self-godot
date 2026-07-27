"""Deterministic procedural generation for Task 0024BAD submission SFX."""

from __future__ import annotations

import math
import os
import wave


SAMPLE_RATE = 44100
BITS = 16
CHANNELS = 1
AMP = 0.45
MAX_AMP = 32767


SFX_EVENTS = [
    {
        "event_id": "ui_focus_or_move",
        "path": "audio/sfx/ui/focus_move.wav",
        "duration_ms": 72,
        "segments": [
            {"start_ms": 0, "duration_ms": 72, "start_hz": 760.0, "end_hz": 1040.0, "gain": 0.42},
        ],
    },
    {
        "event_id": "ui_confirm",
        "path": "audio/sfx/ui/confirm.wav",
        "duration_ms": 120,
        "segments": [
            {"start_ms": 0, "duration_ms": 60, "start_hz": 720.0, "end_hz": 720.0, "gain": 0.46},
            {"start_ms": 60, "duration_ms": 60, "start_hz": 1040.0, "end_hz": 1040.0, "gain": 0.42},
        ],
    },
    {
        "event_id": "you_move",
        "path": "audio/sfx/gameplay/you_move.wav",
        "duration_ms": 96,
        "segments": [
            {"start_ms": 0, "duration_ms": 96, "start_hz": 320.0, "end_hz": 470.0, "gain": 0.46},
        ],
    },
    {
        "event_id": "echo_move",
        "path": "audio/sfx/gameplay/echo_move.wav",
        "duration_ms": 104,
        "segments": [
            {"start_ms": 0, "duration_ms": 50, "start_hz": 400.0, "end_hz": 520.0, "gain": 0.40},
            {"start_ms": 50, "duration_ms": 54, "start_hz": 560.0, "end_hz": 680.0, "gain": 0.40},
        ],
    },
    {
        "event_id": "blocked_invalid",
        "path": "audio/sfx/gameplay/blocked_invalid.wav",
        "duration_ms": 120,
        "segments": [
            {"start_ms": 0, "duration_ms": 120, "start_hz": 205.0, "end_hz": 120.0, "gain": 0.50},
        ],
    },
    {
        "event_id": "level_complete",
        "path": "audio/sfx/gameplay/level_complete.wav",
        "duration_ms": 840,
        "segments": [
            {"start_ms": 0, "duration_ms": 230, "start_hz": 392.0, "end_hz": 523.25, "gain": 0.42},
            {"start_ms": 230, "duration_ms": 280, "start_hz": 523.25, "end_hz": 659.25, "gain": 0.40},
            {"start_ms": 510, "duration_ms": 330, "start_hz": 659.25, "end_hz": 880.0, "gain": 0.36},
        ],
    },
    {
        "event_id": "wall_bump",
        "path": "audio/sfx/gameplay/wall_bump.wav",
        "duration_ms": 110,
        "segments": [
            {"start_ms": 0, "duration_ms": 110, "start_hz": 290.0, "end_hz": 195.0, "gain": 0.44},
        ],
    },
    {
        "event_id": "plate_activate",
        "path": "audio/sfx/gameplay/plate_activate.wav",
        "duration_ms": 180,
        "segments": [
            {"start_ms": 0, "duration_ms": 70, "start_hz": 332.0, "end_hz": 440.0, "gain": 0.46},
            {"start_ms": 70, "duration_ms": 60, "start_hz": 392.0, "end_hz": 523.25, "gain": 0.44},
            {"start_ms": 130, "duration_ms": 50, "start_hz": 523.25, "end_hz": 392.0, "gain": 0.38},
        ],
    },
    {
        "event_id": "door_open",
        "path": "audio/sfx/gameplay/door_open.wav",
        "duration_ms": 240,
        "segments": [
            {"start_ms": 0, "duration_ms": 90, "start_hz": 330.0, "end_hz": 440.0, "gain": 0.42},
            {"start_ms": 90, "duration_ms": 100, "start_hz": 261.63, "end_hz": 392.0, "gain": 0.40},
            {"start_ms": 190, "duration_ms": 50, "start_hz": 523.25, "end_hz": 523.25, "gain": 0.35},
        ],
    },
]


def clamp_i16(value: float) -> int:
    if value >= 1.0:
        value = 0.99995
    if value <= -1.0:
        value = -1.0
    return int(round(value * MAX_AMP))


def ease_out_quad(t: float) -> float:
    return 1.0 - (1.0 - t) * (1.0 - t)


def sine_wave(frame_index: int, segment: dict[str, float], sample_rate: int) -> float:
    start = int(segment["start_ms"] * sample_rate / 1000.0)
    end = start + int(segment["duration_ms"] * sample_rate / 1000.0)
    if frame_index < start or frame_index >= end:
        return 0.0

    segment_pos = float(frame_index - start) / max(1, end - start - 1)
    hz = segment["start_hz"] + (segment["end_hz"] - segment["start_hz"]) * segment_pos
    window = ease_out_quad(segment_pos) if segment_pos > 0.5 else (segment_pos * segment_pos)
    gain = segment["gain"] * window
    phase = 2.0 * math.pi * hz * frame_index / sample_rate
    return gain * math.sin(phase)


def render_frames(duration_ms: int, segments: list[dict[str, float]], sample_rate: int) -> list[int]:
    total_frames = int(duration_ms * sample_rate / 1000.0)
    samples = []
    for frame in range(total_frames):
        amplitude = 0.0
        for segment in segments:
            amplitude += sine_wave(frame, segment, sample_rate)
        attenuation = 1.0 if total_frames == 0 else 1.0 - (frame / total_frames)
        amplitude *= attenuation
        amplitude *= AMP
        samples.append(clamp_i16(amplitude))
    return samples


def write_wav(path: str, samples: list[int], sample_rate: int) -> None:
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with wave.open(path, "wb") as wav:
        wav.setnchannels(CHANNELS)
        wav.setsampwidth(BITS // 8)
        wav.setframerate(sample_rate)
        packed = b"".join(int(v).to_bytes(2, byteorder="little", signed=True) for v in samples)
        wav.writeframes(packed)


def generate_all() -> None:
    for event in SFX_EVENTS:
        samples = render_frames(
            event["duration_ms"],
            event["segments"],
            SAMPLE_RATE,
        )
        write_wav(event["path"], samples, SAMPLE_RATE)
        assert os.path.exists(event["path"])


if __name__ == "__main__":
    generate_all()
