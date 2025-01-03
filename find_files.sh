#1/bin/bash

dir=$1
ext=$2

if [ $#2 -ne 2 ]; then
    echo "Пожалуйста, укажите директорию и расширение файлов"
    exit 1
fi

if [ ! -d $dir ]; then
    echo "Директория не найдена"
    exit 1
fi

files=$(find "$dir" -type f -name "*.$ext")

if [ -z $files ]; then
    echo "Файлы с расширением $ext не найдены"
else
    echo "Найденные файлы с расширением $ext:"
    echo $files
fi