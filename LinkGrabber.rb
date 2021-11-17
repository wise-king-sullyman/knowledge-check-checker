require 'pry'

file = File.open('./test.md', 'r')

file_array = file.readlines

def find_knowledge_check_section(file_array)
  knowledge_check_start_index, knowledge_check_end_index = nil

  file_array.each.with_index do |line, index|
    knowledge_check_start_index = index if line.include?('### Knowledge Check')

    knowledge_check_end_index = index

    if knowledge_check_start_index && (line.include?('### Additional Resources') || line.include?('### Conclusion'))
      break
    end
  end
  { start: knowledge_check_start_index, length: knowledge_check_end_index - knowledge_check_start_index }
end

foo = find_knowledge_check_section(file_array)

knowledge_check_section = file_array.slice(foo[:start], foo[:length])

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
