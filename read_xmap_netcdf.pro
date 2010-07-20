function read_xmap_netcdf, file, range=range
    ; Read the file
    fileData = read_nd_netcdf(file, range=range)
    xmapData = decode_xmap_buffers(fileData)
    return, xmapData
end


