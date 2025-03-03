## Стандартные горячие клавиши Vim

### Основные команды
- `i` — режим вставки
- `Esc` — выход из режима вставки
- `:w` — сохранить файл
- `:q` — выйти из Vim
- `:wq` — сохранить и выйти
- `:q!` — выйти без сохранения
- `u` — отменить последнее действие
- `Ctrl + r` — повторить отменённое действие
- `dd` — удалить строку
- `yy` — копировать строку
- `p` — вставить строку
- `x` — удалить символ под курсором
- `ciw` — заменить текущее слово
- `diw` — удалить текущее слово
- `cw` — изменить слово с начала
- `c$` — изменить строку с текущего положения курсора

### Навигация
- `h` — влево
- `l` — вправо
- `j` — вниз
- `k` — вверх
- `0` — в начало строки
- `$` — в конец строки
- `gg` — в начало файла
- `G` — в конец файла
- `Ctrl + d` — прокрутка вниз на пол-экрана
- `Ctrl + u` — прокрутка вверх на пол-экрана
- `Ctrl + b` — прокрутка вверх на страницу
- `Ctrl + f` — прокрутка вниз на страницу
- `w` — переход к следующему слову
- `b` — переход к предыдущему слову
- `%` — переход к парной скобке

### Окна и буферы
- `:vsp` — открыть вертикальный сплит
- `:sp` — открыть горизонтальный сплит
- `Ctrl + w h` — перейти в левое окно
- `Ctrl + w l` — перейти в правое окно
- `Ctrl + w j` — перейти в нижнее окно
- `Ctrl + w k` — перейти в верхнее окно
- `Ctrl + w q` — закрыть текущее окно
- `Ctrl + w o` — закрыть все окна, кроме текущего
- `:bn` — переключиться на следующий буфер
- `:bp` — переключиться на предыдущий буфер
- `:bd` — закрыть текущий буфер

### Поиск и замена
- `/текст` — поиск текста вперед
- `?текст` — поиск текста назад
- `n` — переход к следующему совпадению
- `N` — переход к предыдущему совпадению
- `:%s/старый/новый/g` — замена всех вхождений в файле
- `:%s/старый/новый/gc` — замена всех вхождений с подтверждением

### Визуальный режим
- `v` — включить визуальный режим
- `V` — включить визуальный режим строк
- `Ctrl + v` — включить блочный визуальный режим
- `y` — копировать выделенный текст
- `d` — вырезать выделенный текст
- `p` — вставить после курсора
- `P` — вставить перед курсором

### Командный режим
- `:e имя_файла` — открыть файл
- `:w` — сохранить файл
- `:q` — выйти из Vim
- `:wq` — сохранить и выйти
- `:q!` — выйти без сохранения
- `:x` — сохранить и выйти (если файл изменён)
- `:ls` — список открытых буферов
- `:b номер` — переключиться на буфер с указанным номером
- `:noh` — отключить подсветку поиска

## Дополнительные горячие клавиши Neovim

### Улучшенная навигация
- `H` — перемещение в начало экрана
- `M` — перемещение в центр экрана
- `L` — перемещение в конец экрана
- `zz` — центрировать экран на текущей строке
- `zt` — прокрутить так, чтобы текущая строка была сверху экрана
- `zb` — прокрутить так, чтобы текущая строка была снизу экрана

### Работа с терминалом в Neovim
- `:term` — открыть терминал
- `Ctrl + \, Ctrl + n` — выйти из терминального режима
- `Ctrl + w N` — переместить терминал в нормальный режим

### Расширенные команды поиска
- `*` — поиск текущего слова вперед
- `#` — поиск текущего слова назад
- `gd` — перейти к определению
- `gD` — перейти к определению в файле
- `K` — открыть документацию для слова под курсором

### Прочие полезные команды
- `J` — объединить текущую строку со следующей
- `gJ` — объединить строки без добавления пробела
- `Ctrl + a` — увеличить число под курсором
- `Ctrl + x` — уменьшить число под курсором
