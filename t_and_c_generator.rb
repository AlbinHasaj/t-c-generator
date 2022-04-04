# frozen_string_literal: true

class TAndCGenerator
  def initialize
    @dataset ||= {}
  end

  def generate
    p 'Please provide clauses you want to use i.e Today is great weather, Tomorrow will rain MAKE SURE TO USE , after set of words'
    @clauses = gets.chomp
    create_clauses
    p 'Type number of clauses in order that you want to use i.e 2 4 1 MAKE SURE TO USE , after set of numbers'
    @sections = gets.chomp
    create_sections
    p 'Please add text and clauses or sections i.e I will [CLAUSE-1]'
    @text = gets.chomp
    compile_text_dataset
    print
  end

  def create_clauses
    @dataset['clauses'] ||= []
    id = 1
    @clauses.split(',').each do |clause|
      @dataset['clauses'] << { id: id, text: clause }
      id += 1
    end
  end

  def create_sections
    @dataset['sections'] ||= []
    id = 1
    @sections.split(',').each do |section|
      @dataset['sections'] << { id: id, clauses_id: section.split(' ') }
      id += 1
    end
  end

  def compile_text_dataset
    @dataset['clauses'].each { |clause| @text.gsub!("[CLAUSE-#{clause[:id]}]", clause[:text]) }
    @dataset['sections'].each do |section|
      @text.gsub!("[SECTION-#{section[:id]}]", clauses_in_section(section[:clauses_id].map(&:to_i)))
    end
  end

  def clauses_in_section(clauses_id)
    section_text = ''
    clauses_id.each do |id|
      section_text += "#{@dataset['clauses'][id - 1][:text]} "
    end
    section_text.rstrip
  end

  def print
    p @text
  end
end
