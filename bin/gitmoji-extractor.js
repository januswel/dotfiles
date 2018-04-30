const gitmojis = require('./gitmojis.json').gitmojis

gitmojis.forEach(gitmoji => {
  console.log(`${gitmoji.code} ${gitmoji.description}`)
})
