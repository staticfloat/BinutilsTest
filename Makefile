SYSIMG_PATH := build/BinutilsTest-v1.so

$(SYSIMG_PATH):
	julia --project=. build_sysimage.jl

# To test, start the system image in a completely new depot, get rid of the `Artifacts.toml` file
# and ask for the binutils path
test: $(SYSIMG_PATH)
	rm -rf build/depot
	JULIA_DEPOT_PATH=build/depot \
	julia -J$(SYSIMG_PATH) -e 'import .BinutilsTest; BinutilsTest.get_binutils_path()'
