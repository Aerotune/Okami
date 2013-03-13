Gem::Specification.new do |s|
  s.name        = 'okami'
  s.version     = '0.0.4'
  s.date        = '2013-03-12'
  s.summary     = "Okami minimal Gosu!"
  s.description = "Gosu Interface with fancy functionality for simplicity."
  s.author      = "Bue Grønlund"
  s.email       = 'aerotune@gmail.com'
  s.has_rdoc    = true
  s.files       = ["lib/okami.rb",
                   "lib/okami/window.rb",
                   "lib/okami/keyboard.rb",
                   "lib/okami/mouse.rb",
                   "lib/okami/mouse_trap.rb",
                   "lib/okami/image.rb",
                   "lib/okami/hit_mask.rb",
                   "lib/okami/sprite.rb",
                   "lib/okami/os.rb"]
                   
  s.homepage    = 'https://github.com/Aerotune/Okami'
  s.add_runtime_dependency 'gosu'
  s.requirements << "To use Okami::HitMask you need to have the 'texplay' gem installed"
end