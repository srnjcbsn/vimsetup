Config {
    font = "xft:Consolas-12",
    position = Top,
    lowerOnStart = True,
    commands = [
        Run Date "%a %b %_d %H:%M" "date" 10,
        Run StdinReader
    ],
    sepChar = "%",
    alignSep = "}{",
    template = " %StdinReader% }{ %cpu% %multicpu%   Mem: %memory% %swap%    %battery%   %date% "
}
