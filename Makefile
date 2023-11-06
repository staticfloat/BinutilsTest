SYSIMG_PATH := build/BinutilsTest-v1.so
JULIA := julia

$(SYSIMG_PATH):
	$(JULIA) -e 'import Pkg; Pkg.activate("."); Pkg.resolve(); Pkg.instantiate()'
	$(JULIA) -e 'import Pkg; Pkg.activate("BinutilsTest"); Pkg.resolve(); Pkg.instantiate()'
	$(JULIA) --project=. build_sysimage.jl

# We have multiple tests here, deleting the depot, deleting the `Artifacts.toml`, etc...
test: $(SYSIMG_PATH)
	rm -rf build/depot
	rm -f BinutilsTest/Artifacts.toml
	JULIA_DEPOT_PATH=build/depot \
	$(JULIA) -J$(SYSIMG_PATH) -e 'import .BinutilsTest; @show BinutilsTest.get_binutils_path()'
