Dir[Rails.root.join "lib/core_ext/**/**.rb"].each do |e|
  require e
end
