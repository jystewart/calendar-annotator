SimpleCov.start 'rails' do
  add_filter "/features/"
  add_filter "/test/"
end
SimpleCov.use_merging true
