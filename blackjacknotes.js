App - MODEL for blackjack game
  !! initialize -> set deck (generates new Deck), playerHand, and dealerHand

Card - MODEL for each individual card
  !! initialize -> set revealed, value, rankName, and suitName
    // cards all start off revealed, only one dealer card covered
    // value 10 for JQK, 2-9 otherwise, or 11/1 for Ace
    // rankName indidicates face value or JQK/Ace -> note that Ace can take value 1 or 11
  !! flip -> set revealed to opposite


Deck - COLLECTION for remaining cards with model of Card
  !! initialize -> generates 52-card Deck (rank from 0 to 12, suit from 0 to 3)
  !! dealPlayer -> new Hand with two cards
  !! dealDealer -> new Hand with two cards and indidicates dealer

Hand - COLLECTION for player/dealer hand with model of Card
  !! initialize -> saves parameters cards, deck, and isDealer
  !! hit -> adds Card from Deck, returns most recently added card
  !! hasAce -> returns 1 if Ace is present, otherwise 0
  !! minScore -> minimum score given all revealed Cards, covered cards not counted
  !! scores -> array of potential scores to deal with Ace being equal to 1 or 11


AppView -> VIEW for entire blackjack game
  !! events: handles hit/stand buttons
  !! initialize -> calls render
  !! render -> detach children, creates html, generates new HandViews for player and dealer

CardView -> VIEW for individual cards '.card'
  !! initialize -> calls render
  !! render -> detach children, creates html, and keeps card covered when necessary

HandView - VIEW for player/dealer cards '.hand'
  !! initialize -> render hand and sets listener for add/remove/change, which trigger re-render
  !! render -> detach children, creates html, and adds minimum score





!!!!!!!!!!!   IMPLEMENT
stand method in Hand for player
  reveal dealer hand
  check score
  alert winner
  start new round
score checker for dealer since one card is not revealed
score checker every time someone hits
dealer has to hit every time player hits
  hit until score = 17, then stop
  takes larger score if have ace



