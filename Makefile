all:
	coffee -o dist -c src/maplist.coffee

dev:
	coffee -o dist -cw src/maplist.coffee

clean:
	rm -rf dist/*