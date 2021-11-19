class LinkFinder
  def initialize(text_array)
    @text_array = text_array
  end

  def get_external_links
    external_link_lines.map do |line|
      external_link(line)
    end
  end

  def get_jump_links
    jump_link_lines.map do |line|
      jump_link(line)
    end
  end

  private

  def external_link_lines
    @text_array.select do |line|
      line.include?('http')
    end
  end

  def external_link(line)
    link_start = line.index('http')
    link_end = line.index('>') - 1
    line[link_start, link_end - link_start]
  end

  def jump_link_lines
    @text_array.select do |line|
      line.include?('href=') && line.include?('#') && !line.include?('http')
    end
  end

  def jump_link(line)
    link_start = line.index('#')
    link_end = line.index('>') - 1
    line[link_start, link_end - link_start]
  end
end