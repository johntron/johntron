const idGenerator = () => {
  let current = 0;
  return () => current++;
}

// Board
const fill = (size, createValue) => Array.from(Array(size)).map(createValue)
const piece = (player, level = 1) => ({ player, level })
const createBoard = (cellCount) => fill(cellCount, () => null)
const placePieces = (board, offset, quantity, player) => {
  Array.from(quantity).forEach(position => {
    board[offset + position] = piece(player)
  })
}
const boardToString = (board, rows, cols) => Array.from(rows)
    .map(row => Array.from(cols)
    .map(col => {const p = board[(row * rows) + col]; console.log('>>>', p); return p})
      .map(piece => `p${piece.player}, l${piece.level}`)
      .join('\t')
    .join('\n'))


// Players
const createPlayers = (quantity, piecesPerPlayer) => fill(quantity, () => ({
  name: '',
  piecesRemaining: piecesPerPlayer,
}));


// Initialization
const playerCount = 2;
const piecesPerPlayer = 16
const boardDimensions = 2;
const boardSizePerDimension = 8;
const players = createPlayers(playerCount, piecesPerPlayer);
const board = createBoard(boardDimensions, boardSizePerDimension)
const gameState = {
  turn: 0,
  currentPlayer: null,
  playerCount: null,

  begin(playerCount) {
    this.playerCount = playerCount
    this.currentPlayer = 0;
  },

  end() {},

  transitionRound() {
    this.currentPlayer += 1;
    this.turn += 1;

    if (this.currentPlayer > this.playerCount) {
      this.currentPlayer = 0;
    }
  }
}
placePieces(board, 0, players[0].piecesRemaining, players[0])
placePieces(board, board.length - players[1].piecesRemaining, players[1].piecesRemaining, players[1])

console.log(`Players: ${players}`)
console.log(`Board: ${boardToString(board, 4, 4)}`)
// const $board = hydrateDom(document, board)
// document.body.appendChild($board)
// console.log(`$board: ${$board}`)
