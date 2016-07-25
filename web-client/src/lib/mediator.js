import EventEmitter from 'events'
EventEmitter.defaultMaxListeners = 1337

class Mediator extends EventEmitter {

}
const mediator = new Mediator()
export default mediator
