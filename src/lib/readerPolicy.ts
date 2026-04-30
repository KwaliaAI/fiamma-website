export const COMPLIMENTARY_READER_BOOKS = 2
export const MEMBERSHIP_PRICE = '£4.99/month'

export function complimentaryReaderSummary(): string {
  return `The first ${COMPLIMENTARY_READER_BOOKS} books are our gift to you. Everything after is Fiamma Membership — from ${MEMBERSHIP_PRICE}.`
}

export function complimentaryReaderMessage(): string {
  return `Your first ${COMPLIMENTARY_READER_BOOKS} books are complimentary.`
}

