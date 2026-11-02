# Hướng Dẫn Dự Án — TikTok Live Temple RPC

## Tech Stack
- Runtime: Bun.js (>= 1.1)
- Backend: Express 4.x, WebSocket (ws 8.x), tiktok-live-connector 2.1.x, JSON-RPC 2.0
- AI Voice: Python 3.10+ ZeroTTS (`zeroweight-ai/ZeroTTS`, model giọng Mai Chi) qua `tts_worker.py`
- Frontend: HTML5 Canvas, Web Audio API, Vanilla JS (không framework)

## Lệnh Chạy & Phát Triển
- Cài dependencies Node/Bun: `bun install`
- Thiết lập môi trường Python: `uv venv .venv && uv pip install --python .venv/bin/python zerotts pillow`
- Khởi chạy dev server: `bun run dev`
- Khởi chạy production: `bun start`
- Khởi chạy Docker: `docker compose up -d --build`

## Cấu Trúc Mã Nguồn
- `server.js`: HTTP + WebSocket JSON-RPC server, TikTok live connector, bộ lọc spam/từ cấm.
- `tts_worker.py`: Worker daemon chạy ZeroTTS với input pipe JSON, chuẩn hóa tiếng Việt, khử clipping audio.
- `public/`: Giao diện Chánh Điện 3 cột (Cấu hình • JSON • Màn Live 9:16), trang live.html độc lập, canvas particles và Web Audio.
- `data/`: Trạng thái công đức (`merit-state.json`) và cache âm thanh (`tts-cache/`).

## Quy Chuẩn
- Giữ tốc độ render canvas khóa 30 FPS (`particles.js`).
- Chặn ký tự spam (Cuneiform, Zalgo, emote rác) tại cả `server.js` và `tts_worker.py`.
- Giữ giao tiếp JSON-RPC 2.0 chuẩn (`method`, `params`, `id`, `error`).
