{ config, pkgs, ... }:

{
  services.yggdrasil = {
    enable = true;
    # Базовая конфигурация, аналогичная сгенерированной на Arch
    settings = {
      # Генерируем новые ключи для этой ноды
      GeneratePrivateKey = true;
      Peers = [
        # Указываем адрес вашего сервера на Arch Linux в локальной сети!
        # Формат: "tcp://IP_СЕРВЕРА_ARCH:порт"
        "tls://192.168.0.20:5555"
        "tcp://srv.itrus.su:7991"
        "tls://srv.itrus.su:7991"
        "ws://srv.itrus.su:7994"
        "tcp://192.168.0.20:5555"
        "tcp://23.43.54.19:25"
        "tcp://ygg-msk-1.averyan.ru:8363"
        "tls://ygg-msk-1.averyan.ru:8362"
        "quic://ygg-msk-1.averyan.ru:8364"
        "tcp://yggno.de:18226"
        "tls://yggno.de:18227"
        "tcp://188.225.9.167:18226"
        "tls://188.225.9.167:18227"
        "tcp://45.147.200.202:12402"
        "tcp://[2a00:b700::a:279]:12402"
        "tls://45.147.200.202:443"
        "tls://[2a00:b700::a:279]:443"
        "tcp://45.95.202.21:12403"
        "tcp://[2a09:5302:ffff::992]:12403"
        "tls://45.95.202.21:443"
        "tls://[2a09:5302:ffff::992]:443"
        "tcp://45.147.200.202:12402"
        "tcp://[2a00:b700::a:279]:12402"
        "tls://45.147.200.202:443"
        "tls://[2a00:b700::a:279]:443"
        "tcp://45.95.202.21:12403"
        "tcp://[2a09:5302:ffff::992]:12403"
        "tls://45.95.202.21:443"
        "tls://[2a09:5302:ffff::992]:443"
        "tcp://ip4.01.msk.ru.dioni.su:9002"
        "tls://ip4.01.msk.ru.dioni.su:9003"
        "quic://ip4.01.msk.ru.dioni.su:9002"
        "ws://ip4.01.msk.ru.dioni.su:9004"
        "tcp://ip6.01.msk.ru.dioni.su:9002"
        "tls://ip6.01.msk.ru.dioni.su:9003"
        "quic://ip6.01.msk.ru.dioni.su:9002"
        "ws://ip6.01.msk.ru.dioni.su:9004"
      ];
      # Остальные настройки можно оставить по умолчанию
    };
  };
}
