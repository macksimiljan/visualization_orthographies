module Queries
  class OrthographyFrequency
    def self.sql_frequency_dialect
      'SELECT s.dialect as name, SUM(a.count) as y
       FROM attestations a, sources s
       WHERE a.source_id = s.id
       GROUP BY s.dialect
       ORDER BY y DESC '
    end

    def self.sql_frequency_text
      'SELECT s.text as name, SUM(a.count) as y
       FROM attestations a, sources s
       WHERE a.source_id = s.id
       GROUP BY s.text
       ORDER BY y DESC '
    end

    def self.sql_frequency(attribute)
      "SELECT s.#{attribute} as name, SUM(a.count) as y
       FROM attestations a, sources s
       WHERE a.source_id = s.id
       GROUP BY s.#{attribute}
       ORDER BY y DESC"
    end
  end
end
