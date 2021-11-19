require 'pry'

require_relative './SectionFinder'
require_relative './LinkFinder'

file = File.open('./test.md', 'r')
file_array = file.readlines
lesson = SectionFinder.new(file_array)
knowledge_check_section = lesson.find_section('Knowledge Check')

links = LinkFinder.new(knowledge_check_section)

puts links.get_external_links

puts links.get_jump_links
