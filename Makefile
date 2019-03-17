OPENOCD_RELEASE_FILE=openocd.release
PROJ_NAME=embed
TARGET=thumbv7em-none-eabihf
BUILD_DIR=target/${TARGET}/release/
ELF_NAME=${BUILD_DIR}/${PROJ_NAME}
BIN_NAME=${ELF_NAME}.bin

all: build

build:
	cargo build --release

bin: build
	arm-none-eabi-objcopy -O binary ${ELF_NAME} ${BIN_NAME}

upload: bin
	openocd -f openocd.cfg -f openocd.release \
		-c "flash write_image erase unlock ${BIN_NAME} 0x08000000; reset run; shutdown"

debug:
	cargo run
