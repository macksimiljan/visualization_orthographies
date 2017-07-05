class Tree

  def fetch(root)
    tree = []
    @leaves_count = 0
    @maximum_count = 0

    tree_greek = {}
    greek_lemma = GreekLemma.find(root)
    tree_greek[:url] = "http://localhost:3000/greek_lemmas/#{root}"
    tree_greek[:class] = pos_to_node_class(greek_lemma.pos)
    tree_greek[:tooltip] = "#{greek_lemma.pos.downcase} #{greek_lemma.meaning}"
    tree_greek[:name] = greek_lemma.label
    tree_greek[:parent] = 'null'
    tree_greek[:children] = []

    coptic_sublemmas = CopticSublemma.where(greek_lemma_id: root)
    coptic_sublemmas.each do |coptic|
      tree_coptic = coptic_sublemma_tree(coptic, tree_greek[:name])
      tree_greek[:children] << tree_coptic
    end
    tree_greek[:children] = sort_coptic_sublemmas(tree_greek[:children])

    tree_greek[:leaves_count] = @leaves_count
    tree_greek[:maximum_count] = @maximum_count
    tree << tree_greek
  end

  private

  def sort_coptic_sublemmas(coptic_tress)
    sorted = coptic_tress.sort_by do |tree|
      if tree[:children].empty?
        tree[:url]
      elsif tree[:children].first[:children].empty?
        tree[:children].first[:url]
      else
        key = tree[:children].first[:children].first[:name]
        key
      end
    end
    sorted.reverse
  end

  def coptic_sublemma_tree(coptic_sublemma, parent)
    tree_coptic = {}
    tree_coptic[:url] = "http://localhost:3000/coptic_sublemmas/#{coptic_sublemma.id}"
    tree_coptic[:class] = pos_to_node_class(coptic_sublemma.pos)
    tree_coptic[:tooltip] = 'tbd'
    tree_coptic[:name] = coptic_sublemma.label
    tree_coptic[:parent] = parent
    tree_coptic[:children] = []

    orthographies = Orthography.where(coptic_sublemma_id: coptic_sublemma.id)
    orthographies.each do |orthography|
      tree_ortho = orthography_tree(orthography, tree_coptic[:name])
      tree_coptic[:children] << tree_ortho
    end
    tree_coptic[:children] = sort_orthographies(tree_coptic[:children])
    tree_coptic
  end

  def sort_orthographies(orthography_trees)
    sorted = orthography_trees.sort_by do |tree|
      if tree[:children].empty?
        tree[:url]
      else
        tree[:children].first[:name]
      end
    end
    sorted.reverse
  end

  def orthography_tree(orthography, parent)
    tree_ortho = {}
    tree_ortho[:url] = "http://localhost:3000/orthographies/#{orthography.id}"
    tree_ortho[:class] = 'internal-node'
    tree_ortho[:tooltip] = 'tbd'
    tree_ortho[:name] = orthography.label
    tree_ortho[:parent] = parent
    tree_ortho[:children] = sources_tree(orthography.sources,
                                         tree_ortho[:name],
                                         orthography.id)
    tree_ortho
  end

  def sources_tree(sources, parent, parent_id)
    tree_sources = []
    data = deduplicate_sources(sources, parent_id)
    data.each_pair do |key, values|
      tree_sources << leaf_tree(parent, values)
    end
    tree_sources
  end

  def deduplicate_sources(sources, parent_id)
    data = {}
    sources.each do |source|
      leaf = create_leaf(source)
      if data.include? leaf[:key]
        data[leaf[:key]][:ids] << source.id unless data[leaf[:key]][:ids].include? source.id
      else
        data[leaf[:key]] = {}
        data[leaf[:key]][:ids] = [source.id]
        data[leaf[:key]][:dialect] = leaf[:dialect]
        data[leaf[:key]][:label] = leaf[:label]
        data[leaf[:key]][:count] = source
                                   .attestations
                                   .where(orthography_id: parent_id)
                                   .pluck(:count)
                                   .sum
        update_maximum_count(data[leaf[:key]][:count])
        increment_leaves_count
      end
    end
    Hash[data.sort_by { |key, _| key }.reverse]
  end

  def create_leaf(source)
    delim = '   '
    dialect = source.dialect.nil? ? '-' : source.dialect
    dating = determine_dating(source.dating_start, source.dating_end)
    manuscript = source.manuscript.nil? ? '-' : source.manuscript
    key = dating.to_s.rjust(4) + dialect
    label = "⌚#{dating.to_s.rjust(4)}#{delim}👤 #{dialect.ljust(2)}#{delim}📄 #{manuscript}"
    return {key: key, label: label, dialect: dialect}
  end

  def determine_dating(dating_start, dating_end)
    if dating_start.nil? && dating_end.nil?
      '-'
    elsif dating_start.nil?
      dating_end.round(-1).to_s
    elsif dating_end.nil?
      dating_start.round(-1).to_s
    else
      ((dating_start + dating_end) / 2).round(-1).to_s
    end
  end

  def leaf_tree(parent, values)
    tree_leaf = {}
    tree_leaf[:url] = "http://localhost:3000/sources?ids=#{values[:ids]}"
    tree_leaf[:class] = dialect_to_node_class(values[:dialect])
    tree_leaf[:text_class] = 'leaf-tree-text'
    tree_leaf[:tooltip] = 'tbd'
    tree_leaf[:name] = values[:label]
    tree_leaf[:parent] = parent
    tree_leaf[:count] = values[:count]
    tree_leaf[:is_leaf] = true
    tree_leaf
  end



  def increment_leaves_count
    @leaves_count += 1
  end

  def update_maximum_count(count)
    @maximum_count = [count, @maximum_count].max
  end

  def pos_to_node_class(pos)
    pos = pos.downcase
    if %w[noun verb adjective adverb].include? pos
      "internal-node #{pos}-node"
    else
      'internal-node'
    end
  end

  def dialect_to_node_class(dialect)
    dialect = dialect.downcase[0]
    if %w[a s m b l].include? dialect
      "#{dialect}-dialect-node leaf-node"
    elsif not dialect.nil?
      'x-dialect-node leaf-node'
    else
      'leaf-node'
    end
  end
end