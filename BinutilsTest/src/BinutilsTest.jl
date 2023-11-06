module BinutilsTest
using LazyArtifacts

function get_binutils_path()
    return artifact"Binutils"
end

end # module BinutilsTest
