# UTM에 우분투 설치 → Deokjil OS 적용 가이드 (Apple Silicon)

Deokjil OS는 macOS에서 **개발**하고, 실제 **적용·테스트는 우분투(GNOME)** 에서 합니다.
애플 실리콘 맥(M1~M4)에서는 UTM으로 ARM64 우분투를 거의 네이티브 속도로 돌릴 수 있어요.

> 요약: UTM 설치 → 우분투 ARM64 ISO 받기 → VM 생성(Virtualize) → 우분투 설치 → `git clone` 후 `./install.sh`.

---

## 0. 준비물

- 애플 실리콘 맥 (M1/M2/M3/M4)
- 여유 디스크 **25GB+**, 할당할 RAM **4GB+**, CPU **4코어** 권장
- 인터넷 (ISO ~3~4GB 다운로드)

---

## 1. UTM 설치

```bash
brew install --cask utm
```

또는 [mac.getutm.app](https://mac.getutm.app/)에서 `.dmg`를 받아 Applications로 드래그.
(Mac App Store 버전은 유료지만 내용은 동일 — 사이트 버전은 무료)

---

## 2. 우분투 ARM64 ISO 다운로드

둘 중 하나. **Deokjil OS는 Ubuntu 24.04+ / GNOME 47+에서 강조색까지 동작**해요.

- **권장(최신): Ubuntu 26.04 LTS** — 2026년 4월 출시, ARM 데스크톱 **공식 지원**.
  → [ubuntu.com/download/desktop](https://ubuntu.com/download/desktop) 에서 ARM64 데스크톱.
- **안정/검증된 대안: Ubuntu 24.04.3 LTS ARM64 데스크톱**
  → 직접 링크: `https://cdimage.ubuntu.com/releases/24.04.3/release/ubuntu-24.04.3-desktop-arm64.iso`

> ️ 반드시 **ARM64(aarch64)** 이미지를 받으세요. amd64(x86) 이미지는 애플 실리콘에서 느린 에뮬레이션이 돼요.

---

## 3. UTM에서 VM 만들기

1. UTM 실행 → **Create a New Virtual Machine** → **Virtualize** (Emulate 아님! ARM이라 가상화가 빠름)
2. **Linux** 선택
3. **Boot ISO Image** → 2번에서 받은 우분투 ISO 선택
4. (선택) **Apple Virtualization** 체크 시 더 빠르지만, GUI 호환은 기본(QEMU) 백엔드 + **virtio-gpu**가 더 무난해요. GUI가 깨지면 이 옵션을 끄세요.
5. **Hardware**: 메모리 4096MB+, CPU 4코어. **Hardware OpenGL Acceleration** 켜기(GPU 가속).
6. **Storage**: 25~64GB
7. 이름 `deokjil-ubuntu` 등으로 저장

---

## 4. 우분투 설치

1. VM 시작 → "Try or Install Ubuntu" 부팅
2. 설치 마법사: 언어/키보드 → **일반 설치** → 디스크 전체 사용(VM 안의 가상 디스크라 안전) → 사용자 생성 → 설치
3. 설치 끝나면 재부팅 안내가 나와요. **재부팅 전에 UTM에서 ISO를 드라이브에서 제거**:
   - VM 정지 → 설정(Settings) → 해당 CD/USB 드라이브 → ISO 비우기(Clear) → 다시 시작
   (안 빼면 다시 설치 화면으로 부팅됨)

---

## 5. VM 편의 세팅 (클립보드·해상도)

QEMU 백엔드 기준, 게스트(우분투) 안에서:

```bash
sudo apt update
sudo apt install -y spice-vdagent qemu-guest-agent
sudo reboot
```

- `spice-vdagent`: 맥↔우분투 **클립보드 공유 + 창 크기에 맞춘 자동 해상도**
- 그래도 해상도가 안 맞으면 설정 → Displays에서 수동 조정

---

## 6. Deokjil OS 적용

우분투 안에서:

```bash
sudo apt install -y git
git clone https://github.com/dj258255/deokjil-os.git
cd deokjil-os

# (1) 대화형으로 고르며 적용
./customize.sh        # 메뉴에서 테마/강조색/배경/마스코트 선택 → 'a' (저장+적용)

# (2) 또는 패키지까지 한 번에
./install.sh          # apt 패키지 설치 + 현재 설정 적용
```

설정만 손으로 바꾸고 싶으면:

```bash
mkdir -p ~/.config/deokjil
cp config/default.conf ~/.config/deokjil/user.conf
nano ~/.config/deokjil/user.conf   # 값 편집
./apply.sh
```

> 강조색이 안 바뀌면 GNOME 버전 확인(24.04+/GNOME 47+ 필요). 테마 변경은 로그아웃→로그인 후 완전히 반영될 수 있어요.

---

## 7. Before/After 스크린샷 (포트폴리오용)

1. 적용 **전** 깨끗한 GNOME 데스크톱 캡처 (우분투에서 `PrtSc` 또는 GNOME 스크린샷)
2. `./customize.sh`로 강조색·배경·테마 바꿔 적용
3. 적용 **후** 캡처
4. 두 장을 Deokjil OS 연재 글/프로젝트 카드에 넣으면 "config 한 줄로 이렇게 변한다"가 한눈에 보여요.

---

## 트러블슈팅

- **GUI가 검거나 깨짐** → VM 설정에서 Apple Virtualization 끄고 QEMU 백엔드 + Display를 `virtio-gpu-gl`(OpenGL)로.
- **부팅이 자꾸 설치 화면** → ISO를 드라이브에서 안 뺀 것(5단계 참고).
- **느림** → Emulate로 만든 것일 수 있음. 반드시 **Virtualize + ARM64 ISO**.
- **인터넷 안 됨** → VM 설정 Network를 `Shared Network`로.

---

### 참고

- [UTM 공식](https://mac.getutm.app/) · [UTM 우분투 가이드](https://docs.getutm.app/guides/ubuntu/)
- [Ubuntu for ARM 다운로드](https://ubuntu.com/download/server/arm)
- [Install Ubuntu on Apple Silicon with UTM (Lorenzo Bettini, 2025)](https://www.lorenzobettini.it/2025/10/install-ubuntu-on-apple-silicon-macs-using-utm/)
