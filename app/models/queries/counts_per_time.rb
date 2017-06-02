module Queries
  class CountsPerTime
    def self.sql_greek_lemma
      'SELECT DISTINCT greek_lemmas.id, orthos.dating_start, orthos.dating_end
        FROM greek_lemmas, coptic_sublemmas, (
          SELECT orthographies.id, orthographies.coptic_sublemma_id, sources.dating_start, sources.dating_end
          FROM orthographies, attestations, sources
          WHERE orthographies.id = attestations.orthography_id
            AND attestations.source_id = sources.id
            AND sources.dating_start IS NOT NULL
            AND sources.dating_end IS NOT NULL
        ) AS orthos
        WHERE greek_lemmas.id = coptic_sublemmas.greek_lemma_id
          AND coptic_sublemmas.id = orthos.coptic_sublemma_id
        ORDER BY orthos.dating_start'
    end

    def self.sql_coptic_sublemma
      'SELECT DISTINCT coptic_sublemmas.id, orthos.dating_start, orthos.dating_end
        FROM coptic_sublemmas, (
          SELECT orthographies.id, orthographies.coptic_sublemma_id, sources.dating_start, sources.dating_end
          FROM orthographies, attestations, sources
          WHERE orthographies.id = attestations.orthography_id
            AND attestations.source_id = sources.id
            AND sources.dating_start IS NOT NULL
            AND sources.dating_end IS NOT NULL
        ) AS orthos
        WHERE coptic_sublemmas.id = orthos.coptic_sublemma_id
        ORDER BY orthos.dating_start'
    end

    def self.sql_orthography
      'SELECT DISTINCT orthographies.id, sources.dating_start, sources.dating_end
          FROM orthographies, attestations, sources
          WHERE orthographies.id = attestations.orthography_id
            AND attestations.source_id = sources.id
            AND sources.dating_start IS NOT NULL
            AND sources.dating_end IS NOT NULL
       ORDER BY sources.dating_start'
    end

    def self.sql_source
      'SELECT DISTINCT sources.id, sources.dating_start, sources.dating_end
          FROM sources
          WHERE sources.dating_start IS NOT NULL
            AND sources.dating_end IS NOT NULL
       ORDER BY sources.dating_start'
    end
  end
end
