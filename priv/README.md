# How to update the resource tsv files?

## env
As a conversion script imports xlrd package, install it with pip. Recommends virtualenv:

```
$ mkvirtualenv --python=`which python` --no-site-packages municipality
$ pip install xlrd
```

## build the files

- Download the municipality code at MIC(http://www.soumu.go.jp/denshijiti/code.html)

```
$ wget http://www.soumu.go.jp/main_content/000318342.xls
```

- update the source file with the script like following:

```
$ python build_source.py 000318342.xls
```
