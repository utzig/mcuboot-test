BLINKY := k64f_blinky
BLINKY2 := k64f_blinky2

BOOT_RSA := k64f_boot_rsa
BOOT_EC := k64f_boot_ec
BOOT_EC256 := k64f_boot_ec256
BOOT_RSA_EC := k64f_boot_rsa_ec

RSA_KEY_1 := key_rsa.pem
RSA_KEY_2 := key_rsa_2.pem

BLINKY2_IMG := bin/targets/$(BLINKY2)/app/apps/blinky/blinky.img

FLASH_ERASE := pyocd-flashtool -ce

NEWTMGR_CONN := --conn k64f
NEWTMGR_IMG := newtmgr $(NEWTMGR_CONN) image

all: build-apps build-mcuboot

build-blinky:
	@echo "* Building first app... \c"
	@newt build -q $(BLINKY)
	@echo "ok"

build-blinky2:
	@echo "* Building second app... \c"
	@newt build -q $(BLINKY2)
	@echo "ok"

build-boot-rsa:
	@echo "* Building mcuboot with RSA... \c"
	@newt build -q $(BOOT_RSA)
	@echo "ok"

build-boot-ec:
	@echo "* Building mcuboot with EC... \c"
	@newt build -q $(BOOT_EC)
	@echo "ok"

build-boot-ec256:
	@echo "* Building mcuboot with EC256... \c"
	@newt build -q $(BOOT_EC256)
	@echo "ok"

build-boot-rsa-ec:
	@echo "* Building mcuboot with RSA + EC... \c"
	@newt build -q $(BOOT_RSA_EC)
	@echo "ok"

build-apps: build-blinky build-blinky2

build-mcuboot: build-boot-rsa build-boot-ec build-boot-ec256 build-boot-rsa-ec

clean:
	rm -rf bin/

.PHONY: all clean
