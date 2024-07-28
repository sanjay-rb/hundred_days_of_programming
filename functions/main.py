from datetime import datetime
from firebase_functions import scheduler_fn
from firebase_admin import initialize_app, firestore
from google.api_core.datetime_helpers import DatetimeWithNanoseconds

# Application Default credentials are automatically created.
app = initialize_app()


@scheduler_fn.on_schedule(schedule="0 0 * * *", timezone=scheduler_fn.Timezone("Asia/Kolkata"))
def update_streak(event: scheduler_fn.ScheduledEvent) -> None:
    db = firestore.client()
    users_ref = db.collection('users')
    users = users_ref.stream()

    batch = db.batch()
    current_date = datetime.now()

    for user in users:
        user_ref = user.reference
        user_data = user.to_dict()
        last_submitted_date = user_data.get(
            'lastSubmittedDate', DatetimeWithNanoseconds.now(),
        )
        streak = user_data.get('streak', 0)
        max_streak = user_data.get('maxStreak', 0)

        # Calculate day difference
        last_submitted_date = datetime.fromtimestamp(
            last_submitted_date.timestamp())
        day_diff = (current_date - last_submitted_date).days

        # Determine new streak value
        if day_diff == 1:
            new_streak = streak + 1
        elif day_diff > 1:
            new_streak = 0
        else:
            new_streak = streak

        # Update max streak if necessary
        if new_streak > max_streak:
            max_streak = new_streak

        # Prepare batch update
        batch.update(user_ref, {'streak': new_streak, 'maxStreak': max_streak})

    # Commit the batch update
    batch.commit()

    print('Successfully updated streaks for all users')
