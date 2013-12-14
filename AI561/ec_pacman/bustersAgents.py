import util
from game import Agent
from game import Directions
from keyboardAgents import KeyboardAgent
import inference
import busters
from random import randint

class BustersAgent:
  "An agent that tracks and displays its beliefs about ghost positions."

  def __init__( self, index = 0, inference = "ExactInference", ghostAgents = None ):
    inferenceType = util.lookup(inference, globals())
    self.inferenceModules = [inferenceType(a) for a in ghostAgents]

  def registerInitialState(self, gameState):
    "Initializes beliefs and inference modules"
    import __main__
    self.display = __main__._display
    for inference in self.inferenceModules: inference.initialize(gameState)
    self.ghostBeliefs = [inf.getBeliefDistribution() for inf in self.inferenceModules]
    self.firstMove = True

  def observationFunction(self, gameState):
    "Removes the ghost states from the gameState"
    agents = gameState.data.agentStates
    gameState.data.agentStates = [agents[0]] + [None for i in range(1, len(agents))]
    return gameState

  def getAction(self, gameState):
    "Updates beliefs, then chooses an action based on updated beliefs."
    for index, inf in enumerate(self.inferenceModules):
      if not self.firstMove: inf.elapseTime(gameState)
      self.firstMove = False
      inf.observeState(gameState)
      self.ghostBeliefs[index] = inf.getBeliefDistribution()
    self.display.updateDistributions(self.ghostBeliefs)
    return self.chooseAction(gameState)

  def chooseAction(self, gameState):
    "By default, a BustersAgent just stops.  This should be overridden."
    return Directions.STOP

class BustersKeyboardAgent(BustersAgent, KeyboardAgent):
  "An agent controlled by the keyboard that displays beliefs about ghost positions."

  def __init__(self, index = 0, inference = "ExactInference", ghostAgents = None):
    KeyboardAgent.__init__(self, index)
    BustersAgent.__init__(self, index, inference, ghostAgents)

  def getAction(self, gameState):
    return BustersAgent.getAction(self, gameState)

  def chooseAction(self, gameState):
    return KeyboardAgent.getAction(self, gameState)

from distanceCalculator import Distancer
from game import Actions
from game import Directions

class GreedyBustersAgent(BustersAgent):
  "An agent that charges the closest ghost."
  def registerInitialState(self, gameState):
    "Pre-computes the distance between every two points."
    BustersAgent.registerInitialState(self, gameState)
    self.distancer = Distancer(gameState.data.layout, False)

  def chooseAction(self, gameState):
    """
    First computes the most likely position of each ghost that
    has not yet been captured, then chooses an action that brings
    Pacman closer to the closest ghost (in maze distance!).

    To find the maze distance between any two positions, use:
    self.distancer.getDistance(pos1, pos2)

    To find the successor position of a position after an action:
    successorPosition = Actions.getSuccessor(position, action)

    To get a list of booleans, one for each agent, indicating whether
    or not the agent is alive, use gameState.getLivingGhosts()
    Note that pacman is always agent 0, so the ghosts are agents 1,
    onwards (just as before).

    You may remove Directions.STOP from the list of available actions.
    """

    "*** YOUR CODE HERE ***"
    targetPositions = []
    dist=[]
    print "-----"
    pacmanPosition = gameState.getPacmanPosition()
    livingGhost = gameState.getLivingGhosts()
    numGhost=gameState.getNumAgents()
    for i in xrange(1, numGhost):
        if livingGhost[i]:
            beliefs = self.ghostBeliefs[i - 1]
            optimalKey = max(beliefs, key=beliefs.get)
            targetPositions.append(optimalKey)
        else:
            targetPositions.append(999)
    for i in xrange(0,len(targetPositions)):
        if targetPositions[i]!=999:
            dist.append(self.distancer.getDistance(pacmanPosition, targetPositions[i]))
        else:
            dist.append(0)
    print 'target positions'
    print targetPositions
    print 'dist from each TP'
    print dist
    dist_new=[]
    for i in xrange(0,len(dist)):
        if dist[i]!=0:
            dist_new.append(dist[i])

    for i in range(0,len(dist)):
        if min(dist_new)==dist[i]:
            ghostNearest=i
    print 'Ghost number nearest to pacman'
    print ghostNearest
    print 'pos of Nearest ghost'
    print targetPositions[ghostNearest]
    act=[]
    legal = [a for a in gameState.getLegalPacmanActions() if a != Directions.STOP]
    distFromLegal=[]
    for action in legal:
        successorPosition = Actions.getSuccessor(pacmanPosition, action)
        distFromLegal.append(self.distancer.getDistance(successorPosition, targetPositions[ghostNearest]))
    print 'Dist from each legal to nearest ghost'
    print distFromLegal
    print 'Min dist from among avail actions'
    minDistFromLegal=min(distFromLegal)
    print minDistFromLegal

    for i in range(0,len(distFromLegal)):
        if minDistFromLegal==distFromLegal[i]:
            indexMinDist=i
    print 'Index of legal action'
    print indexMinDist
    print 'legal actions'
    print legal
    return legal[indexMinDist]
    #util.raiseNotDefined()
