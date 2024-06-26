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

These scripts created for JetHub H1 developed by JetHome. Scripts makes it able to use Wi-Fi AP (Access Point) mode, that is imposible by default

- Target OS: Armbian (but I think it will work on Ubuntu too)
- Target Device: JetHub H1, Fn-Link 6222B-SRC (RTL8822CS), meson64 (aarch64, ARM64)

This way you can use it as (at least almost) a full-fledged Wi-Fi router

**However**, the device manufacturer reports that performance and stability in this mode are not guaranteed

Please check all these scripts before use them, change credentials (if you want of course)

After executing this main script it should be able to use secondary scripts: **jethub-start-ap.sh** and **jethub-stop-ap.sh**

You may need to remove or change some lines about disabling services and so on

**In theory**, scripts are idempotent and can be used at any time during system operation. The result will be the same. However, it is better to use these scripts on clean images and not use the resulting version of the system for copying to other devices, because this violates network security

[ ! ]: Due to the fact that it will operate in router (master) mode, you may experience network problems when connecting it to an existing network. In most cases, this may be due to incorrect IP range settings of the DHCP server on JetHub, which conflict with the master device. In such cases, you will need to check the host settings and change the JetHub configurations to resolve conflicts

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

Эти скрипты написаны для JetHub H1, разработанный JetHome. Скрипты позволяют использовать его в качестве беспроводной Wi-Fi точки доступа, что невозможно по-умолчанию

- Целевая ОС: Armbian (но думаю и на Ubuntu будет работать)
- Целевое устройство: JetHub H1, Fn-Link 6222B-SRC (RTL8822CS), meson64 (aarch64, ARM64)

Таким образом вы сможете использовать его в качестве (по краней мере почти) полноценного Wi-Fi роутера

**Однако**, производитель устройства сообщает, что работоспособность и стабильность в таком режиме не гарантирована

Пожалуйста, перед использованием проверьте все скрипты, измените реквизиты (если хотите конечно)

После выполнения главного скрипта, можно использовать вторичные: **jethub-start-ap.sh** и **jethub-stop-ap.sh**

Вы возможно захотите убрать или изменить некоторые шаги (например про выключение сервисов и типо того)

**По идее** скрипты идемпотентны и их можно использовать в любой момент работы системы. Результат будет тот же. Однако лучше использовать эти скрипты на чистых образах и не использовать полученный вариант системы для копирования на другие устройства, т.к. это нарушает безопасность сети

[ ! ]: В связи с тем, что он будет работать в режиме роутера (master), у вас могут возникнуть проблемы с сетью при подключении его к уже существующей сети. В большинстве случаев это может быть связано с неправильными настройками IP-диапазона DHCP сервера на JetHub, которые конфликтуют с главным master-устроством. В таких случаях потребуется провести проверку настроек главного устройства и изменить конфигурации JetHub для разрешения конфликтов

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
