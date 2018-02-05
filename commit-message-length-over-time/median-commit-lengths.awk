
# expected input: git --no-pager log --no-merges --reverse --oneline --pretty=format:'%cD%%%s' (-F % as an argument here)

# Countt the number of words in a string
function words_in_string(string) {
  words = split(string, _fields, " ")
  return words
}

# Calculate the median legnth of each item.
# It is assumed that list is a numbered array
function median_words_of_list(list) {
  for (idx in list) {
    item = list[idx]
    word_counts[idx] = words_in_string(item)
  }
  asort(word_counts, sorted_word_counts)
  return sorted_word_counts[int(idx / 2)]
}

function average_words_of_list(list) {
  sum_lengths = 0
  for (idx in list) {
    sum_lengths = sum_lengths + words_in_string(list[idx])
  }
  return sum_lengths/idx
}

BEGIN {
  OFS = "%"
}

{
  date = $1
  message = $2
  messages[FNR] = message
  split(date, date_fields, " ")
  dates[FNR] = date
  medians[FNR] = median_words_of_list(messages)
  averages[FNR] = average_words_of_list(messages)
}

END {
  for (idx in messages) {
    print dates[idx], messages[idx],medians[idx],averages[idx]
  }
}
