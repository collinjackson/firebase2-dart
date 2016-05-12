library firebase.disconnect;

import 'dart:async';

/**
 * The Disconnect class encapsulates all operations to be performed on a
 * Firebase when the client is disconnected. This allows you to write or
 * clear data when your client disconnects from the Firebase servers. These
 * updates occur whether your client disconnects cleanly or not, so you can
 * rely on them to clean up data even if a connection is dropped or a client
 * crashes.
 *
 * Note that these functions should be called before any data is written to
 * avoid problems if a connection is dropped before the requests can be
 * transferred to the Firebase servers.
 *
 * Note that onDisconnect operations are only triggered once. If you want an
 * operation to occur each time a disconnect occurs, you'll need to
 * re-establish the operations each time.
 */
abstract class Disconnect {

  /**
   * Ensure the data at this location is set to the specified value when the
   * client is disconnected (due to closing the browser, navigating to a new
   * page, or network issues).
   */
  Future set(value);

  /**
   * Ensure the data at this location is set to the specified value and
   * priority when the client is disconnected (due to closing the browser,
   * navigating to a new page, or network issues).
   */
  Future setWithPriority(value, priority);

  /**
   * Write the enumerated children at this Firebase location when the client is
   * disconnected (due to closing the browser, navigating to a new page, or
   * network issues). This will overwrite only children enumerated in the
   * 'value' parameter and will leave others untouched.
   *
   * If the values specified for the children are objects, update will merely
   * set those values. It will not recursively 'update' those children. Passing
   * null as a value for a child is equivalent to calling remove() on that
   * child.
   */
  Future update(value);

  /**
   * Ensure the data at this location is deleted when the client is
   * disconnected (due to closing the browser, navigating to a new page, or
   * network issues).
   *
   * remove() is equivalent to calling set(null);
   */
  Future remove();

  /**
   * Cancel all previously queued onDisconnect() set or update events for this
   * location and all children.
   *
   * If a write has been queued for this location via a set() or update() at a
   * parent location, the write at this location will be canceled though all
   * other siblings will still be written.
   */
  Future cancel();
}
