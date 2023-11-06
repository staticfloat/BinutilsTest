using PackageCompiler, Pkg, TOML, Base.BinaryPlatforms

# Activate the main `BinutilsTest` project, as that's what `create_sysimage` expects
Pkg.activate(joinpath(@__DIR__, "BinutilsTest"))
sysimage_path = joinpath(@__DIR__, "build", "BinutilsTest-v1.$(platform_dlext(HostPlatform()))")
mkpath(dirname(sysimage_path))
create_sysimage(
    ["BinutilsTest"];
    sysimage_path,
)
