App = {
    contracts: {},
    init: async () => {
        console.log("Loaded...")
        await App.loeadEthereum()
        await App.loadAccount()
        await App.loadContracts()
        await App.render()
        await App.renderTransactions()
    },
    loeadEthereum: async () => {
        if(window.ethereum){
            App.web3provider = window.ethereum;
            await window.ethereum.request({method: 'eth_requestAccounts'})
        }else{
            console.log('No ethereum browser installed')
        }
    },
    loadContracts: async () => {
        const res = await fetch('TasksContract.json')
        const tasksContractJSON = await res.json()
        App.contracts.tasksContract = TruffleContract(tasksContractJSON);
        App.contracts.tasksContract.setProvider(App.web3provider);

        App.tasksContract = await App.contracts.tasksContract.deployed()

    },
    render: () => {
        document.getElementById('account').innerText = App.account;
    },

    renderTransactions: async () => {
        const taskCounter = await App.tasksContract.tasksCounter();
        const taskCounterNumber = taskCounter.toNumber();

        let html = '';

        for(let i=taskCounterNumber; i>0; i--){
            const task = await App.tasksContract.tasks(i);
            const id = task[0];
            const title = task[1];
            const description = task[2];
            const date = task[4];

            let taskElement = `
                <div class="card rounded-2 mb-2">
                    <div class="card-header">
                        <span>${title}</span>
                    </div>
                    <div class="card-body">
                        <span>${description}</span>
                        <p class="text-muted">Transaction was createad at ${new Date(date * 1000).toLocaleString()}</p>
                    </div>
                </div>
            `
            html += taskElement;

            document.querySelector("#tasksList").innerHTML = html;
        }
    },

    createTask: async (title, description) => {
        const result = await App.tasksContract.createTask(title, description, {from: App.account});
        console.log(result.logs[0].args)
    },

    loadAccount: async () => {
        const accounts = await window.ethereum.request({method: 'eth_requestAccounts'})
        App.account = accounts[0];
    }
}

App.init()