module ShortenerLib
  ALPHABET ="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789./:".split(//)
  URL_REGEX = /\b((https?):\/\/([\w\.-]+[\.]\w+)?)([-A-Z0-9+&@#\/%?=~_|$!:,.;]*[-A-Z0-9+&@#\/%=~_|$])?/i

  def self.generate(url)
    return unless URL_REGEX.match(url)

    decode(URL_REGEX.match(url)[3])
  end

  protected

  def self.decode(url)
    bijective_decode(url)
  end

  def self.bijective_encode(i)
    # from http://refactormycode.com/codes/125-base-62-encoding
    # with only minor modification
    return ALPHABET[0] if i == 0
    s = ''
    base = ALPHABET.length
    while i > 0
      s << ALPHABET[i.modulo(base)]
      i /= base
    end
    s.reverse
  end

  def self.bijective_decode(string)
    # based on base2dec() in Tcl translation
    # at http://rosettacode.org/wiki/Non-decimal_radices/Convert#Ruby
    i = 0

    base = ALPHABET.length
    string.each_char { |char| i = i * base + ALPHABET.index(char) }

    i
  end
end
