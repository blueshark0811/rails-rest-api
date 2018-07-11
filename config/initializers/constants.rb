API_VERSION = 1
REGEXP = {
  subdomain: /\A[a-z0-9](?:[a-z0-9\-]{0,61}[a-z0-9])?\z/i,
  domain: /\A[a-z0-9]*(\.?[a-z0-9]+)\.[a-z]{2,5}(:[0-9]{1,5})?(\/.)?\z/ix,
  youtube_id: /(?:.be\/|embed\/|\/watch\?v=|\/(?=p\/))([\w\/\-]+)/
}
SORT_FLAGS = %w[ASC DESC]
