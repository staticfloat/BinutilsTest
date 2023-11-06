using PackageCompiler, Pkg, TOML, Base.BinaryPlatforms

# Prepare system image for the same CPU targets that base Julia itself uses
# X-ref: https://github.com/JuliaCI/julia-buildkite/blob/main/utilities/build_envs.sh
cpu_targets = Dict(
    "x86_64" => "generic;sandybridge,-xsaveopt,clone_all;haswell,-rdrnd,base(1)",
    "aarch64" => "generic;cortex-a57;thunderx2t99;carmel",
)
if !haskey(cpu_targets, arch(HostPlatform()))
    error("Don't know what CPU target to use for '$(arch(HostPlatform()))'")
end
cpu_target = cpu_targets[arch(HostPlatform())]

# Activate the main `BinutilsTest` project, as that's what `create_sysimage` expects
Pkg.activate(joinpath(@__DIR__, "BinutilsTest"))
sysimage_path = joinpath(@__DIR__, "build", "BinutilsTest-v1.$(platform_dlext(HostPlatform()))")
mkpath(dirname(sysimage_path))
create_sysimage(
    ["BinutilsTest"];
    sysimage_path,
    cpu_target,
)
