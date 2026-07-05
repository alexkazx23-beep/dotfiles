# Dotfiles

我的个人配置文件，通过符号链接管理。基于 [CachyOS](https://cachyos.org/) (Arch Linux)，使用 [niri](https://github.com/YaLTeR/niri) 作为窗口管理器。

## 目录结构

```
~/dotfiles/
├── Makefile          # install / uninstall / update
├── config/           # → ~/.config/
│   ├── kitty/        # 终端模拟器
│   ├── niri/         # 窗口管理器 + dms + scripts
│   ├── fcitx5/       # 输入法 (Rime)
│   ├── fish/         # Fish shell
│   ├── fuzzel/       # 应用启动器
│   ├── fastfetch/    # 系统信息
│   ├── btop/         # 系统监控
│   ├── matugen/      # 配色生成器（模板）
│   ├── yazi/         # 文件管理器
│   ├── mpv/          # 媒体播放器
│   ├── satty/        # 截图工具
│   ├── pacseek/      # Pacman 前端
│   ├── fontconfig/   # 字体配置
│   ├── gtk-3.0/      # GTK3 主题
│   ├── gtk-4.0/      # GTK4 主题
│   ├── qt5ct/        # Qt5 主题
│   ├── qt6ct/        # Qt6 主题
│   ├── xsettingsd/   # X 设置
│   ├── environment.d/# 环境变量
│   ├── cava/         # 音频可视化
│   ├── nvim/         # Neovim (LazyVim)
│   └── starship.toml # Shell 提示符
└── home/             # → ~/
    ├── .zshrc
    ├── .zprofile
    ├── .gitconfig
    ├── bin/          # 个人脚本
    └── ...
```

## 安装

```bash
git clone https://github.com/Alexkazx/dotfiles.git ~/dotfiles
cd ~/dotfiles
make install
```

`make install` 会将配置文件符号链接到对应位置。如果目标位置已有文件，会自动备份（添加 `.bak.时间戳` 后缀）。

## 卸载

```bash
cd ~/dotfiles
make uninstall
```

只会删除指向本仓库的符号链接，不会影响其他文件。

## 更新

```bash
cd ~/dotfiles
make update
```

相当于 `git pull && make install`。

## 首次安装后需要做的事

### Matugen（配色生成）

运行 matugen 来根据当前壁纸生成所有主题配色：

```bash
matugen image /path/to/your/wallpaper.png
```

这会更新 starship、gtk、fuzzel、btop、cava、fastfetch 等所有 matugen 管理的配色文件。

### Rime 输入法

Rime 配置在 `config/fcitx5/rime/`。首次使用需要安装 rime-ice 字典：

```bash
# 安装 rime-ice 字典到 ~/.local/share/fcitx5/rime/
# 参考: https://github.com/iDvel/rime-ice
```

### Yazi 文件管理器

安装 flavors：

```bash
cd ~/.config/yazi
ya pack -i
```

### Neovim

首次启动 nvim 时 LazyVim 会自动安装插件。
