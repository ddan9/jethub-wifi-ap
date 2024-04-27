# jethub-wifi-ap

<br />

### Language translations

- [🇺🇸 Description in English](#Description-in-English)

- [🇷🇺 Описание на Русском](#Описание-на-Русском)

<br />

---

<br />

### Description in English

[🇺🇸 🔝 Go up](#Language-translations)

#### Menu:

- [Description ⏪](#Description)

- [Installation ⏪](#Installation)

- [Usage ⏪](#Usage)

<br />

#### Description:

These scripts created for JetHub H1. Scripts makes it able to use AP (Access Point) Wi-Fi mode, that is imposible by default

- Target OS: Armbian (but I think it will work on Ubuntu too)
- Target Device: JetHub H1, Fn-Link 6222B-SRC (RTL8822CS), meson64 (aarch64, ARM64)

Please check all these scripts before use them, change credentials (if you want of course)
After executing this main script it should be able to use secondary scripts: jethub-start-ap.sh and jethub-stop-ap.sh
You may need to remove or change some lines about disabling services and so on

[🔙 Menu](#Menu)

<br />

#### Installation:

[ ! ]: ALL FROM ROOT

Basic system installation and getting ready:

```bash
apt install -y git pwgen
cd
git clone https://github.com/ddan9/jethub-wifi-ap
cd ./jethub-wifi-ap
chmod +x ./*.sh
./jethub-system-install.sh
```

Additionally (if you want use scripts as systems):

```bash
cd
mv jethub-wifi-ap .jethub-wifi-ap
ln -s /root/.jethub-wifi-ap/jethub-start-ap.sh /usr/sbin/jethub-start-ap
ln -s /root/.jethub-wifi-ap/jethub-stop-ap.sh /usr/sbin/jethub-stop-ap
```

[🔙 Menu](#Menu)

<br />

#### Usage:

[ ! ]: It is assumed that you have completed an additional installation step

For starting AP. There is no additional options

```bash
jethub-start-ap
```

For simple stop AP:

```bash
jethub-stop-ap
```

For stop AP with full interface disabling:

```bash
jethub-stop-ap --full-remove-interface
```

[🔙 Menu](#Menu)

<br />

### Описание на Русском

[🇷🇺 🔝 Наверх](#Language-translations)

#### Меню:

- [Описание ⏪](#Описание)

- [Установка ⏪](#Установка)

- [Использование ⏪](#Использование)

<br />

#### Описание:

Эти скрипты написаны для JetHub H1. Скрипты позволяют использовать его в качестве беспроводной Wi-Fi точки доступа, что невозможно по-умолчанию

- Целевая ОС: Armbian (Но думаю и на Ubuntu будет работать)
- Целевое устройство: JetHub H1, Fn-Link 6222B-SRC (RTL8822CS), meson64 (aarch64, ARM64)

Пожалуйста, перед использованием проверьте все скрипты, измените реквизиты (если хотите конечно)
После выполнения главного скрипта, можно использовать вторичные: jethub-start-ap.sh and jethub-stop-ap.sh
Вы возможно захотите убрать или изменить некоторые шаги (например про выключение сервисов и типо того)

[🔙 Меню](#Меню)

<br />

#### Установка:

[ ! ]: ВСЁ ОТ РУТА

Базовая установка и подготовка системы:

```bash
apt install -y git pwgen
cd
git clone https://github.com/ddan9/jethub-wifi-ap
cd ./jethub-wifi-ap
chmod +x ./*.sh
./jethub-system-install.sh
```

Дополнительно (если хотите использовать скрипты в виде системных):

```bash
cd
mv jethub-wifi-ap .jethub-wifi-ap
ln -s /root/.jethub-wifi-ap/jethub-start-ap.sh /usr/sbin/jethub-start-ap
ln -s /root/.jethub-wifi-ap/jethub-stop-ap.sh /usr/sbin/jethub-stop-ap
```

[🔙 Меню](#Меню)

<br />

#### Использование:

[ ! ]: Предполагается, что вы проделали дополнительный шаг установки

Для поднятия точки. Никаких дополнительных параметров нет

```bash
jethub-start-ap
```

Для простого выключения точки:

```bash
jethub-stop-ap
```

Для выключения точки с полным выключением интерфейса:

```bash
jethub-stop-ap --full-remove-interface
```

[🔙 Меню](#Меню)

<br />
