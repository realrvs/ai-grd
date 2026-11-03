pandoc PRESENTATION.md -o PRESENTATION.pdf `
    -t beamer `
    --pdf-engine=xelatex `
    --slide-level=1 `
    -V mainfont="DejaVu Sans" `
    -V monofont="DejaVu Sans Mono" `
    -V theme=Madrid `
    -V aspectratio=169 `
    -V fontsize=12pt `
    -V lang=ru