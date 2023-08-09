MAKEFLAGS += -j4
SOURCES = $(wildcard *.scad)
OUTPUTS = $(patsubst %.scad,%.stl,$(SOURCES))

.PHONY: all clean

all: $(OUTPUTS)

%.stl: %.scad
	openscad -o $@ $<

clean:
	rm -f $(OUTPUTS)
