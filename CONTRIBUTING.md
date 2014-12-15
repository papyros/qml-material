Contributing to QML Material
----------------------------

We welcome contributions to QML Material! This is what makes open source so awesome. We have a few simple guidelines for contributing outlined below.

### Submitting Code

We welcome code contributions via pull requests. Here are some guidelines to follow:

 * If your change is more than a simple fix, make sure there is an [issue](https://github.com/quantum-os/qml-material/issues)  open for the change you are making, and that there has been discussion and approval of the correct solution.

 * When working on code, try to keep your commits as clean as possible. We have a [commit checklist](https://github.com/quantum-os/quantum-os/wiki/Commit-Checklist) with some guidelines for writing great commits.

 * We use [GitFlow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow) for a strict workflow to ensure that our code remains stable and neatly versioned for end users. So make sure you create your working branch off of `develop`, and submit the pull request back to `develop`.

 * Before submitting the pull request, make sure you run the unit tests. Travis CI will test your branch anyway, and we won't merge a pull request until the tests pass, so you should fix them before submitting the pull request.

 * Make sure all relevant documentation is updated for the change. If you're adding a new component, please document it.

 * If you are adding new features, please add new unit tests that test the changes you added.

 * If you're adding a new component, make sure you link to the [Material Design spec](http://www.google.com/design/spec/components/) for it, along with a screenshot of your component.
