SimpleCov.start 'rails' do
  add_filter "/features/"
  add_filter "/test/"
  use_merging true
end
SimpleCov.use_merging true
