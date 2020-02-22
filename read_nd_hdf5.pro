function read_nd_hdf5, file, range=range, dataset=dataset
  if (n_elements(dataset) eq 0) then dataset = '/entry/data/data'
  file_id = h5f_open(file)
  dataset_id = h5d_open(file_id, dataset)
  data = h5d_read(dataset_id)
  h5d_close, dataset_id
  h5f_close, file_id
  return, data
end
