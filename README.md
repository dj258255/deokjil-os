# Deokjil OS

"덕질(deokjil)"하는 사람들을 위한 **우분투 개인화 툴킷**.

특정 마스코트나 테마를 강제하지 않습니다. 대신 **사용자가 자유롭게** 테마·강조색·배경·마스코트를 골라 적용할 수 있는 *커스터마이징 시스템*을 제공합니다. 기본값은 중립적이고, 모든 건 설정(config)으로 바뀝니다.

## 철학

- **config 기반** — `config/`의 값만 바꾸면 외형이 바뀐다
- **모듈식** — 테마/강조색/배경/마스코트가 각각 독립 모듈. 원하는 것만 적용
- **비파괴적** — 기존 우분투 위에 얹는 방식(시스템 파일을 갈아엎지 않음)
- **자유** — 마스코트·테마는 사용자가 추가/교체 가능한 에셋 팩

## 구조

```
deokjil-os/
├── apply.sh             # 현재 설정을 적용
├── customize.sh         # 대화형 커스터마이저 (메뉴로 고름)
├── install.sh           # 패키지 설치 + 최초 적용
├── config/
│   └── default.conf     # 기본 설정 (사용자는 user.conf로 덮어씀)
├── lib/common.sh        # 공통 함수
├── modules/             # 모듈식 적용 스크립트 (번호순 실행)
├── themes/ wallpapers/ mascots/   # 교체 가능한 에셋
└── packages/base.list   # 설치할 apt 패키지
```

## 사용법 (우분투 GNOME에서)

```bash
# 1) 기본 설정을 복사해 내 설정으로
mkdir -p ~/.config/deokjil
cp config/default.conf ~/.config/deokjil/user.conf
# user.conf 를 자유롭게 편집

# 2) 대화형으로 고르거나
./customize.sh
# 3) 설정대로 바로 적용
./apply.sh
```

> 개발은 macOS에서, 실제 적용은 우분투(실기 또는 VM)에서 합니다.
> ISO로 굽는 단계는 우분투의 [Cubic](https://github.com/PJ-Singh-001/Cubic)으로 추후 진행 예정.

## 상태

🚧 초기 스캐폴딩 — 커스터마이징 툴킷(1층) 개발 중.
