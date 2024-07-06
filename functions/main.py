from datetime import datetime
from firebase_functions import scheduler_fn
from firebase_admin import initialize_app, firestore
import google.cloud.firestore
from google.api_core.datetime_helpers import DatetimeWithNanoseconds

# Application Default credentials are automatically created.
app = initialize_app()


@scheduler_fn.on_schedule(schedule="0 0 * * *", timezone=scheduler_fn.Timezone("Asia/Kolkata"))
def update_streak(event: scheduler_fn.ScheduledEvent) -> None:
    print(event.job_name)
    print(event.schedule_time)
    db: google.cloud.firestore.Client = firestore.client()

    users_ref = db.collection('users')
    users = users_ref.stream()

    for user in users:
        # Getting referance of user document
        user_ref = user.reference
        user_data = user.to_dict()

        # Reading current value
        last_submitted_date = user_data.get(
            'lastSubmittedDate', DatetimeWithNanoseconds.now()
        )
        streak = user_data.get('streak', 0)
        max_streak = user_data.get('maxStreak', 0)
        current_date = datetime.now()
        last_submitted_date = datetime.fromtimestamp(
            last_submitted_date.timestamp())

        # Streak updation
        day_diff = (current_date - last_submitted_date).days
        if day_diff == 1:
            new_streak = streak + 1
        elif day_diff > 1:
            new_streak = 0
        else:
            new_streak = streak

        # Max streak updation
        if new_streak > max_streak:
            max_streak = new_streak

        # Updation on firestore
        user_ref.update({'streak': new_streak, 'maxStreak': max_streak})

    print('Successfully updated streaks for all users')
