class QueryParser
  SiteFilter = Struct.new(:domain_name, :url_path)
  attr_reader :site_filters, :filetype_filters, :query

  def initialize(query)
    @query = query
    @site_filters = extract_site_filters
    @filetype_filters = extract_filetype_filters
  end

  def stripped_query
    @query.gsub(/-?site:\S+/i, '').gsub(/filetype:\S+/i, '').squish
  end

  private
  def extract_site_filters
    site_filters = { included_sites: [], excluded_sites: [] }
    @query.gsub(/\(?(-?site:\S+)\b\/?\)?/i) do
      match = $1
      if match.first == '-'
        site_filters[:excluded_sites] << extract_site_filter(match)
      else
        site_filters[:included_sites] << extract_site_filter(match)
      end
    end

    site_filters
  end

  def extract_site_filter(site_param)
    domain_name, url_path = site_param.split('/', 2)
    domain_name.sub!(/\A-?site:/i, '')
    url_path = url_path.present? ? "/#{url_path}" : nil
    SiteFilter.new domain_name, url_path
  end

  def extract_filetype_filters
    filetype_filters = []
    @query.gsub(/\(?(filetype:)(\S+)\b\/?\)?/i) do
      filetype_filters << $2
    end

    filetype_filters
  end
end
