const delay = (ms) => new Promise(resolve => setTimeout(resolve, ms));

async function makeRequests() {
  for (let i = 1; i < 3000; i++) {
    // Make request with a small delay
    fetch('http://localhost/sharks')
      .then((_) => console.log('Requisição realizada com sucesso'))
      .catch((err) => console.error(err));
    
    await delay(100);  // Adding a 10ms delay between requests
  }
}

makeRequests();