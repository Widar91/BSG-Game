Testing
=======

Game development in Unity consists of scenes. In our design, each scene is isolated with regard to both graphics and logic. Only one porgrammer is working on a specific scene at any given time.

Testing assignments
-------------------

Our development process consists of weekly sprints. The final phase of each sprint is the testing phaase. During this phase, every programmer refrains from making significant enhancements to the game. Each member of the team is assigned to every scene they have been working on, as well as additional scenes, so that every scene has at least two persons assigned to it. They then proceed to test the scenes.

During the testing
------------------
The two persons assigned to testing a scene work individually to test the main scenarios, as well as produce as many extreme cases they can think of. The tester may perform tests in sequence or in fresh starts of the game, taking note of the sequence of actions, if applicable.

Every time erroneous or unintended behaviour occurs, the tester attempts to reproduce the error. He or she then opens a new issue on the GitHub project, describing what and where the unintended behaviour was and simplest known way to reproduce the error. Optionally, additional ways to reproduce the error may be included.

Fixing
------
The bug issue on GitHub is assigned to the programmer that was responsible for the scene. Whether the fix will be done during the testing phase or the next sprint is left to the judgement of the programmer responsible for it.
