require 'pry'

require_relative './SectionFinder'

file = File.open('./test.md', 'r')
lesson = SectionFinder.new(file.readlines)
knowledge_check_section = lesson.find_section('Knowledge Check')

external_link_lines = knowledge_check_section.select do |line|
  line.include?('http')
end

def find_external_link(line)
  link_start = line.index('http')
  link_end = line.index('>') - 1
  line[link_start, link_end - link_start]
end

external_links = external_link_lines.map do |line|
  find_external_link(line)
end

jump_links_lines = knowledge_check_section.select do |line|
  line.include?('href=') && line.include?('#') && !line.include?('http')
end

def find_jump_link(line)
  link_start = line.index('#')
  link_end = line.index('>') - 1
  line[link_start, link_end - link_start]
end

jump_links = jump_links_lines.map do |line|
  find_jump_link(line)
end

puts external_links

puts jump_links
