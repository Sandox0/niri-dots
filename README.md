# niri-dots

Mi configuración de escritorio para **niri** en Arch Linux.

## Stack

- **Compositor:** [niri](https://github.com/YaLTeR/niri) (scrolling tiling)
- **Barra:** Waybar
- **Terminal:** Ghostty
- **Notificaciones:** SwayNC
- **Lanzador:** Rofi
- **System info:** fastfetch
- **Shell:** bash + Starship

## Paleta

Slate blue `#6b8cad`, terracota, sage green, fondos oscuros (`#0a0a0c`).
Fuentes: JetBrainsMono Nerd Font + Lexend.

## Estructura

- `config/` — va en `~/.config/`
- `local/bin/` — scripts propios, van en `~/.local/bin/`
- `bashrc` — mi `.bashrc` (shell real es bash, no fish)

## Instalación

```bash
cp -r config/* ~/.config/
cp -r local/bin/* ~/.local/bin/
cp bashrc ~/.bashrc
```

Revisar rutas absolutas dentro de los configs (algunas referencian `/home/felip/...` directamente).
