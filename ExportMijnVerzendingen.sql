DECLARE @VertrekDepartment NVARCHAR(255);
DECLARE @VertrekOrganisatie NVARCHAR(255);
DECLARE @Jaar NVARCHAR(20);

SET @Jaar = '%2023-06%';
SET @VertrekDepartment = '%apotheek%';
SET @VertrekOrganisatie = '%bornem%rivierenland%';

SELECT
    (
        (
            (
                SELECT COUNT(vl.Temperature)
                FROM VehicleLog vl
                JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                WHERE sol.Otw_AB_Vehicle = v.LicensePlate 
                AND vl.EntryDate BETWEEN 
                    IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                    AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
            ) +
            (
                SELECT COUNT(vl.Temperature)
                FROM VehicleLog vl
                JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                WHERE sol.Otw_HH_Vehicle = v.LicensePlate 
                AND vl.EntryDate BETWEEN sol.H1_Pu_TimeStamp AND sol.H2_Do_TimeStamp
            ) +
            (
                SELECT COUNT(vl.Temperature)
                FROM VehicleLog vl
                JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                WHERE sol.Otw_AH_Vehicle = v.LicensePlate 
                AND vl.EntryDate BETWEEN 
                    IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                    AND sol.H1_Do_TimeStamp
            ) +
            (
                SELECT COUNT(vl.Temperature)
                FROM VehicleLog vl
                JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                AND vl.EntryDate BETWEEN 
                    sol.H1_Pu_TimeStamp 
                    AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
            ) +
            (
                SELECT COUNT(vl.Temperature)
                FROM VehicleLog vl
                JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                AND vl.EntryDate BETWEEN 
                    sol.H2_Pu_TimeStamp 
                    AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
            )
        )
    ) AS 'AantalMeetingenNew',
    (
        IIF(
            (
                (
                    (
                        SELECT COUNT(vl.Temperature)
                        FROM VehicleLog vl
                        JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                        WHERE sol.Otw_AB_Vehicle = v.LicensePlate 
                        AND vl.EntryDate BETWEEN 
                            IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                            AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                        AND vl.Temperature < 11
                    ) +
                    (
                        SELECT COUNT(vl.Temperature)
                        FROM VehicleLog vl
                        JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                        WHERE sol.Otw_HH_Vehicle = v.LicensePlate 
                        AND vl.EntryDate BETWEEN sol.H1_Pu_TimeStamp AND sol.H2_Do_TimeStamp
                        AND vl.Temperature < 11
                    ) +
                    (
                        SELECT COUNT(vl.Temperature)
                        FROM VehicleLog vl
                        JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                        WHERE sol.Otw_AH_Vehicle = v.LicensePlate 
                        AND vl.EntryDate BETWEEN 
                            IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                            AND sol.H1_Do_TimeStamp
                        AND vl.Temperature < 11
                    ) +
                    (
                        SELECT COUNT(vl.Temperature)
                        FROM VehicleLog vl
                        JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                        WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                        AND vl.EntryDate BETWEEN 
                            sol.H1_Pu_TimeStamp 
                            AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                        AND vl.Temperature < 11
                    ) +
                    (
                        SELECT COUNT(vl.Temperature)
                        FROM VehicleLog vl
                        JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                        WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                        AND vl.EntryDate BETWEEN 
                            sol.H2_Pu_TimeStamp 
                            AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                        AND vl.Temperature < 11
                    )
                ) 
                = 0), NULL, CAST(
                ROUND(
                    (
                        (
                            (
                                (
                                    SELECT COUNT(vl.Temperature)
                                    FROM VehicleLog vl
                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                    WHERE sol.Otw_AB_Vehicle = v.LicensePlate 
                                    AND vl.EntryDate BETWEEN 
                                        IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                    AND vl.Temperature < 11
                                ) +
                                (
                                    SELECT COUNT(vl.Temperature)
                                    FROM VehicleLog vl
                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                    WHERE sol.Otw_HH_Vehicle = v.LicensePlate 
                                    AND vl.EntryDate BETWEEN sol.H1_Pu_TimeStamp AND sol.H2_Do_TimeStamp
                                    AND vl.Temperature < 11
                                ) +
                                (
                                    SELECT COUNT(vl.Temperature)
                                    FROM VehicleLog vl
                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                    WHERE sol.Otw_AH_Vehicle = v.LicensePlate 
                                    AND vl.EntryDate BETWEEN 
                                        IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                        AND sol.H1_Do_TimeStamp
                                    AND vl.Temperature < 11
                                ) +
                                (
                                    SELECT COUNT(vl.Temperature)
                                    FROM VehicleLog vl
                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                    WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                    AND vl.EntryDate BETWEEN 
                                        sol.H1_Pu_TimeStamp 
                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                    AND vl.Temperature < 11
                                ) +
                                (
                                    SELECT COUNT(vl.Temperature)
                                    FROM VehicleLog vl
                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                    WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                    AND vl.EntryDate BETWEEN 
                                        sol.H2_Pu_TimeStamp 
                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                    AND vl.Temperature < 11
                                )
                            )
                            /
                            (
                                CASE 
                                    WHEN 
                                    (
                                        (
                                            (
                                                (
                                                    SELECT COUNT(vl.Temperature)
                                                    FROM VehicleLog vl
                                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                                    WHERE sol.Otw_AB_Vehicle = v.LicensePlate 
                                                    AND vl.EntryDate BETWEEN 
                                                        IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                                ) +
                                                (
                                                    SELECT COUNT(vl.Temperature)
                                                    FROM VehicleLog vl
                                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                                    WHERE sol.Otw_HH_Vehicle = v.LicensePlate 
                                                    AND vl.EntryDate BETWEEN sol.H1_Pu_TimeStamp AND sol.H2_Do_TimeStamp
                                                ) +
                                                (
                                                    SELECT COUNT(vl.Temperature)
                                                    FROM VehicleLog vl
                                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                                    WHERE sol.Otw_AH_Vehicle = v.LicensePlate 
                                                    AND vl.EntryDate BETWEEN 
                                                        IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                                        AND sol.H1_Do_TimeStamp
                                                ) +
                                                (
                                                    SELECT COUNT(vl.Temperature)
                                                    FROM VehicleLog vl
                                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                                    WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                                    AND vl.EntryDate BETWEEN 
                                                        sol.H1_Pu_TimeStamp 
                                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                                ) +
                                                (
                                                    SELECT COUNT(vl.Temperature)
                                                    FROM VehicleLog vl
                                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                                    WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                                    AND vl.EntryDate BETWEEN 
                                                        sol.H2_Pu_TimeStamp 
                                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                                )
                                            )
                                        ) = 0
                                    ) 
                                    THEN 1 
                                    ELSE
                                    (
                                        (
                                            SELECT COUNT(vl.Temperature)
                                            FROM VehicleLog vl
                                            JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                            WHERE sol.Otw_AB_Vehicle = v.LicensePlate 
                                            AND vl.EntryDate BETWEEN 
                                                IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                                AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                        ) +
                                        (
                                            SELECT COUNT(vl.Temperature)
                                            FROM VehicleLog vl
                                            JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                            WHERE sol.Otw_HH_Vehicle = v.LicensePlate 
                                            AND vl.EntryDate BETWEEN sol.H1_Pu_TimeStamp AND sol.H2_Do_TimeStamp
                                        ) +
                                        (
                                            SELECT COUNT(vl.Temperature)
                                            FROM VehicleLog vl
                                            JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                            WHERE sol.Otw_AH_Vehicle = v.LicensePlate 
                                            AND vl.EntryDate BETWEEN 
                                                IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                                AND sol.H1_Do_TimeStamp
                                        ) +
                                        (
                                            SELECT COUNT(vl.Temperature)
                                            FROM VehicleLog vl
                                            JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                            WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                            AND vl.EntryDate BETWEEN 
                                                sol.H1_Pu_TimeStamp 
                                                AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                        ) +
                                        (
                                            SELECT COUNT(vl.Temperature)
                                            FROM VehicleLog vl
                                            JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                            WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                            AND vl.EntryDate BETWEEN 
                                                sol.H2_Pu_TimeStamp 
                                                AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                        )
                                    )
                                END
                            )
                        )
                        * 100
                    )
                    , 0
                ) 
                AS VARCHAR
            ) + '%'
        )
    ) AS 'Meetingen <11',
    (
        IIF(
            (
                (
                    (
                        SELECT COUNT(vl.Temperature)
                        FROM VehicleLog vl
                        JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                        WHERE sol.Otw_AB_Vehicle = v.LicensePlate 
                        AND vl.EntryDate BETWEEN 
                            IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                            AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                        AND vl.Temperature >= 11 AND vl.Temperature < 13
                    ) +
                    (
                        SELECT COUNT(vl.Temperature)
                        FROM VehicleLog vl
                        JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                        WHERE sol.Otw_HH_Vehicle = v.LicensePlate 
                        AND vl.EntryDate BETWEEN sol.H1_Pu_TimeStamp AND sol.H2_Do_TimeStamp
                        AND vl.Temperature >= 11 AND vl.Temperature < 13
                    ) +
                    (
                        SELECT COUNT(vl.Temperature)
                        FROM VehicleLog vl
                        JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                        WHERE sol.Otw_AH_Vehicle = v.LicensePlate 
                        AND vl.EntryDate BETWEEN 
                            IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                            AND sol.H1_Do_TimeStamp
                        AND vl.Temperature >= 11 AND vl.Temperature < 13
                    ) +
                    (
                        SELECT COUNT(vl.Temperature)
                        FROM VehicleLog vl
                        JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                        WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                        AND vl.EntryDate BETWEEN 
                            sol.H1_Pu_TimeStamp 
                            AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                        AND vl.Temperature >= 11 AND vl.Temperature < 13
                    ) +
                    (
                        SELECT COUNT(vl.Temperature)
                        FROM VehicleLog vl
                        JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                        WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                        AND vl.EntryDate BETWEEN 
                            sol.H2_Pu_TimeStamp 
                            AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                        AND vl.Temperature >= 11 AND vl.Temperature < 13
                    )
                )
                = 0), NULL, CAST(
                ROUND(
                    (
                        (
                            (
                                (
                                    SELECT COUNT(vl.Temperature)
                                    FROM VehicleLog vl
                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                    WHERE sol.Otw_AB_Vehicle = v.LicensePlate 
                                    AND vl.EntryDate BETWEEN 
                                        IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                    AND vl.Temperature >= 11 AND vl.Temperature < 13
                                ) +
                                (
                                    SELECT COUNT(vl.Temperature)
                                    FROM VehicleLog vl
                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                    WHERE sol.Otw_HH_Vehicle = v.LicensePlate 
                                    AND vl.EntryDate BETWEEN sol.H1_Pu_TimeStamp AND sol.H2_Do_TimeStamp
                                    AND vl.Temperature >= 11 AND vl.Temperature < 13
                                ) +
                                (
                                    SELECT COUNT(vl.Temperature)
                                    FROM VehicleLog vl
                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                    WHERE sol.Otw_AH_Vehicle = v.LicensePlate 
                                    AND vl.EntryDate BETWEEN 
                                        IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                        AND sol.H1_Do_TimeStamp
                                    AND vl.Temperature >= 11 AND vl.Temperature < 13
                                ) +
                                (
                                    SELECT COUNT(vl.Temperature)
                                    FROM VehicleLog vl
                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                    WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                    AND vl.EntryDate BETWEEN 
                                        sol.H1_Pu_TimeStamp 
                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                    AND vl.Temperature >= 11 AND vl.Temperature < 13
                                ) +
                                (
                                    SELECT COUNT(vl.Temperature)
                                    FROM VehicleLog vl
                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                    WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                    AND vl.EntryDate BETWEEN 
                                        sol.H2_Pu_TimeStamp 
                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                    AND vl.Temperature >= 11 AND vl.Temperature < 13
                                )
                            )
                            /
                            (
                                CASE 
                                    WHEN 
                                    (
                                        (
                                            (
                                                (
                                                    SELECT COUNT(vl.Temperature)
                                                    FROM VehicleLog vl
                                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                                    WHERE sol.Otw_AB_Vehicle = v.LicensePlate 
                                                    AND vl.EntryDate BETWEEN 
                                                        IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                                ) +
                                                (
                                                    SELECT COUNT(vl.Temperature)
                                                    FROM VehicleLog vl
                                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                                    WHERE sol.Otw_HH_Vehicle = v.LicensePlate 
                                                    AND vl.EntryDate BETWEEN sol.H1_Pu_TimeStamp AND sol.H2_Do_TimeStamp
                                                ) +
                                                (
                                                    SELECT COUNT(vl.Temperature)
                                                    FROM VehicleLog vl
                                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                                    WHERE sol.Otw_AH_Vehicle = v.LicensePlate 
                                                    AND vl.EntryDate BETWEEN 
                                                        IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                                        AND sol.H1_Do_TimeStamp
                                                ) +
                                                (
                                                    SELECT COUNT(vl.Temperature)
                                                    FROM VehicleLog vl
                                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                                    WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                                    AND vl.EntryDate BETWEEN 
                                                        sol.H1_Pu_TimeStamp 
                                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                                ) +
                                                (
                                                    SELECT COUNT(vl.Temperature)
                                                    FROM VehicleLog vl
                                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                                    WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                                    AND vl.EntryDate BETWEEN 
                                                        sol.H2_Pu_TimeStamp 
                                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                                )
                                            )
                                        ) = 0
                                    ) 
                                    THEN 1 
                                    ELSE
                                    (
                                        (
                                            SELECT COUNT(vl.Temperature)
                                            FROM VehicleLog vl
                                            JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                            WHERE sol.Otw_AB_Vehicle = v.LicensePlate 
                                            AND vl.EntryDate BETWEEN 
                                                IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                                AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                        ) +
                                        (
                                            SELECT COUNT(vl.Temperature)
                                            FROM VehicleLog vl
                                            JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                            WHERE sol.Otw_HH_Vehicle = v.LicensePlate 
                                            AND vl.EntryDate BETWEEN sol.H1_Pu_TimeStamp AND sol.H2_Do_TimeStamp
                                        ) +
                                        (
                                            SELECT COUNT(vl.Temperature)
                                            FROM VehicleLog vl
                                            JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                            WHERE sol.Otw_AH_Vehicle = v.LicensePlate 
                                            AND vl.EntryDate BETWEEN 
                                                IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                                AND sol.H1_Do_TimeStamp
                                        ) +
                                        (
                                            SELECT COUNT(vl.Temperature)
                                            FROM VehicleLog vl
                                            JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                            WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                            AND vl.EntryDate BETWEEN 
                                                sol.H1_Pu_TimeStamp 
                                                AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                        ) +
                                        (
                                            SELECT COUNT(vl.Temperature)
                                            FROM VehicleLog vl
                                            JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                            WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                            AND vl.EntryDate BETWEEN 
                                                sol.H2_Pu_TimeStamp 
                                                AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                        )
                                    )
                                END
                            )
                        )
                        * 100
                    )
                    , 0
                ) 
                AS VARCHAR
            ) + '%'
        )
    ) AS 'Meetingen 11-13',
    (
        IIF(
            (
                (
                    (
                        SELECT COUNT(vl.Temperature)
                        FROM VehicleLog vl
                        JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                        WHERE sol.Otw_AB_Vehicle = v.LicensePlate 
                        AND vl.EntryDate BETWEEN 
                            IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                            AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                        AND vl.Temperature >= 13 AND vl.Temperature < 15
                    ) +
                    (
                        SELECT COUNT(vl.Temperature)
                        FROM VehicleLog vl
                        JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                        WHERE sol.Otw_HH_Vehicle = v.LicensePlate 
                        AND vl.EntryDate BETWEEN sol.H1_Pu_TimeStamp AND sol.H2_Do_TimeStamp
                        AND vl.Temperature >= 13 AND vl.Temperature < 15
                    ) +
                    (
                        SELECT COUNT(vl.Temperature)
                        FROM VehicleLog vl
                        JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                        WHERE sol.Otw_AH_Vehicle = v.LicensePlate 
                        AND vl.EntryDate BETWEEN 
                            IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                            AND sol.H1_Do_TimeStamp
                        AND vl.Temperature >= 13 AND vl.Temperature < 15
                    ) +
                    (
                        SELECT COUNT(vl.Temperature)
                        FROM VehicleLog vl
                        JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                        WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                        AND vl.EntryDate BETWEEN 
                            sol.H1_Pu_TimeStamp 
                            AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                        AND vl.Temperature >= 13 AND vl.Temperature < 15
                    ) +
                    (
                        SELECT COUNT(vl.Temperature)
                        FROM VehicleLog vl
                        JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                        WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                        AND vl.EntryDate BETWEEN 
                            sol.H2_Pu_TimeStamp 
                            AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                        AND vl.Temperature >= 13 AND vl.Temperature < 15
                    )
                )
                = 0), NULL, CAST(
                ROUND(
                    (
                        (
                            (
                                (
                                    SELECT COUNT(vl.Temperature)
                                    FROM VehicleLog vl
                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                    WHERE sol.Otw_AB_Vehicle = v.LicensePlate 
                                    AND vl.EntryDate BETWEEN 
                                        IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                    AND vl.Temperature >= 13 AND vl.Temperature < 15
                                ) +
                                (
                                    SELECT COUNT(vl.Temperature)
                                    FROM VehicleLog vl
                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                    WHERE sol.Otw_HH_Vehicle = v.LicensePlate 
                                    AND vl.EntryDate BETWEEN sol.H1_Pu_TimeStamp AND sol.H2_Do_TimeStamp
                                    AND vl.Temperature >= 13 AND vl.Temperature < 15
                                ) +
                                (
                                    SELECT COUNT(vl.Temperature)
                                    FROM VehicleLog vl
                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                    WHERE sol.Otw_AH_Vehicle = v.LicensePlate 
                                    AND vl.EntryDate BETWEEN 
                                        IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                        AND sol.H1_Do_TimeStamp
                                    AND vl.Temperature >= 13 AND vl.Temperature < 15
                                ) +
                                (
                                    SELECT COUNT(vl.Temperature)
                                    FROM VehicleLog vl
                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                    WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                    AND vl.EntryDate BETWEEN 
                                        sol.H1_Pu_TimeStamp 
                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                    AND vl.Temperature >= 13 AND vl.Temperature < 15
                                ) +
                                (
                                    SELECT COUNT(vl.Temperature)
                                    FROM VehicleLog vl
                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                    WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                    AND vl.EntryDate BETWEEN 
                                        sol.H2_Pu_TimeStamp 
                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                    AND vl.Temperature >= 13 AND vl.Temperature < 15
                                )
                            )
                            /
                            (
                                CASE 
                                    WHEN 
                                    (
                                        (
                                            (
                                                (
                                                    SELECT COUNT(vl.Temperature)
                                                    FROM VehicleLog vl
                                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                                    WHERE sol.Otw_AB_Vehicle = v.LicensePlate 
                                                    AND vl.EntryDate BETWEEN 
                                                        IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                                ) +
                                                (
                                                    SELECT COUNT(vl.Temperature)
                                                    FROM VehicleLog vl
                                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                                    WHERE sol.Otw_HH_Vehicle = v.LicensePlate 
                                                    AND vl.EntryDate BETWEEN sol.H1_Pu_TimeStamp AND sol.H2_Do_TimeStamp
                                                ) +
                                                (
                                                    SELECT COUNT(vl.Temperature)
                                                    FROM VehicleLog vl
                                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                                    WHERE sol.Otw_AH_Vehicle = v.LicensePlate 
                                                    AND vl.EntryDate BETWEEN 
                                                        IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                                        AND sol.H1_Do_TimeStamp
                                                ) +
                                                (
                                                    SELECT COUNT(vl.Temperature)
                                                    FROM VehicleLog vl
                                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                                    WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                                    AND vl.EntryDate BETWEEN 
                                                        sol.H1_Pu_TimeStamp 
                                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                                ) +
                                                (
                                                    SELECT COUNT(vl.Temperature)
                                                    FROM VehicleLog vl
                                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                                    WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                                    AND vl.EntryDate BETWEEN 
                                                        sol.H2_Pu_TimeStamp 
                                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                                )
                                            )
                                        ) = 0
                                    ) 
                                    THEN 1 
                                    ELSE
                                    (
                                        (
                                            SELECT COUNT(vl.Temperature)
                                            FROM VehicleLog vl
                                            JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                            WHERE sol.Otw_AB_Vehicle = v.LicensePlate 
                                            AND vl.EntryDate BETWEEN 
                                                IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                                AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                        ) +
                                        (
                                            SELECT COUNT(vl.Temperature)
                                            FROM VehicleLog vl
                                            JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                            WHERE sol.Otw_HH_Vehicle = v.LicensePlate 
                                            AND vl.EntryDate BETWEEN sol.H1_Pu_TimeStamp AND sol.H2_Do_TimeStamp
                                        ) +
                                        (
                                            SELECT COUNT(vl.Temperature)
                                            FROM VehicleLog vl
                                            JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                            WHERE sol.Otw_AH_Vehicle = v.LicensePlate 
                                            AND vl.EntryDate BETWEEN 
                                                IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                                AND sol.H1_Do_TimeStamp
                                        ) +
                                        (
                                            SELECT COUNT(vl.Temperature)
                                            FROM VehicleLog vl
                                            JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                            WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                            AND vl.EntryDate BETWEEN 
                                                sol.H1_Pu_TimeStamp 
                                                AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                        ) +
                                        (
                                            SELECT COUNT(vl.Temperature)
                                            FROM VehicleLog vl
                                            JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                            WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                            AND vl.EntryDate BETWEEN 
                                                sol.H2_Pu_TimeStamp 
                                                AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                        )
                                    )
                                END
                            )
                        )
                        * 100
                    )
                    , 0
                ) 
                AS VARCHAR
            ) + '%'
        )
    ) AS 'Meetingen 13-15',
    (
        IIF(
            (
                (
                    (
                        SELECT COUNT(vl.Temperature)
                        FROM VehicleLog vl
                        JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                        WHERE sol.Otw_AB_Vehicle = v.LicensePlate 
                        AND vl.EntryDate BETWEEN 
                            IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                            AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                        AND vl.Temperature >= 15 AND vl.Temperature < 25
                    ) +
                    (
                        SELECT COUNT(vl.Temperature)
                        FROM VehicleLog vl
                        JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                        WHERE sol.Otw_HH_Vehicle = v.LicensePlate 
                        AND vl.EntryDate BETWEEN sol.H1_Pu_TimeStamp AND sol.H2_Do_TimeStamp
                        AND vl.Temperature >= 15 AND vl.Temperature < 25
                    ) +
                    (
                        SELECT COUNT(vl.Temperature)
                        FROM VehicleLog vl
                        JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                        WHERE sol.Otw_AH_Vehicle = v.LicensePlate 
                        AND vl.EntryDate BETWEEN 
                            IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                            AND sol.H1_Do_TimeStamp
                        AND vl.Temperature >= 15 AND vl.Temperature < 25
                    ) +
                    (
                        SELECT COUNT(vl.Temperature)
                        FROM VehicleLog vl
                        JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                        WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                        AND vl.EntryDate BETWEEN 
                            sol.H1_Pu_TimeStamp 
                            AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                        AND vl.Temperature >= 15 AND vl.Temperature < 25
                    ) +
                    (
                        SELECT COUNT(vl.Temperature)
                        FROM VehicleLog vl
                        JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                        WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                        AND vl.EntryDate BETWEEN 
                            sol.H2_Pu_TimeStamp 
                            AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                        AND vl.Temperature >= 15 AND vl.Temperature < 25
                    )
                )
                = 0), NULL, CAST(
                ROUND(
                    (
                        (
                            (
                                (
                                    SELECT COUNT(vl.Temperature)
                                    FROM VehicleLog vl
                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                    WHERE sol.Otw_AB_Vehicle = v.LicensePlate 
                                    AND vl.EntryDate BETWEEN 
                                        IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                    AND vl.Temperature >= 15 AND vl.Temperature < 25
                                ) +
                                (
                                    SELECT COUNT(vl.Temperature)
                                    FROM VehicleLog vl
                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                    WHERE sol.Otw_HH_Vehicle = v.LicensePlate 
                                    AND vl.EntryDate BETWEEN sol.H1_Pu_TimeStamp AND sol.H2_Do_TimeStamp
                                    AND vl.Temperature >= 15 AND vl.Temperature < 25
                                ) +
                                (
                                    SELECT COUNT(vl.Temperature)
                                    FROM VehicleLog vl
                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                    WHERE sol.Otw_AH_Vehicle = v.LicensePlate 
                                    AND vl.EntryDate BETWEEN 
                                        IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                        AND sol.H1_Do_TimeStamp
                                    AND vl.Temperature >= 15 AND vl.Temperature < 25
                                ) +
                                (
                                    SELECT COUNT(vl.Temperature)
                                    FROM VehicleLog vl
                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                    WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                    AND vl.EntryDate BETWEEN 
                                        sol.H1_Pu_TimeStamp 
                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                    AND vl.Temperature >= 15 AND vl.Temperature < 25
                                ) +
                                (
                                    SELECT COUNT(vl.Temperature)
                                    FROM VehicleLog vl
                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                    WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                    AND vl.EntryDate BETWEEN 
                                        sol.H2_Pu_TimeStamp 
                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                    AND vl.Temperature >= 15 AND vl.Temperature < 25
                                )
                            )
                            /
                            (
                                CASE 
                                    WHEN 
                                    (
                                        (
                                            (
                                                (
                                                    SELECT COUNT(vl.Temperature)
                                                    FROM VehicleLog vl
                                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                                    WHERE sol.Otw_AB_Vehicle = v.LicensePlate 
                                                    AND vl.EntryDate BETWEEN 
                                                        IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                                ) +
                                                (
                                                    SELECT COUNT(vl.Temperature)
                                                    FROM VehicleLog vl
                                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                                    WHERE sol.Otw_HH_Vehicle = v.LicensePlate 
                                                    AND vl.EntryDate BETWEEN sol.H1_Pu_TimeStamp AND sol.H2_Do_TimeStamp
                                                ) +
                                                (
                                                    SELECT COUNT(vl.Temperature)
                                                    FROM VehicleLog vl
                                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                                    WHERE sol.Otw_AH_Vehicle = v.LicensePlate 
                                                    AND vl.EntryDate BETWEEN 
                                                        IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                                        AND sol.H1_Do_TimeStamp
                                                ) +
                                                (
                                                    SELECT COUNT(vl.Temperature)
                                                    FROM VehicleLog vl
                                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                                    WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                                    AND vl.EntryDate BETWEEN 
                                                        sol.H1_Pu_TimeStamp 
                                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                                ) +
                                                (
                                                    SELECT COUNT(vl.Temperature)
                                                    FROM VehicleLog vl
                                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                                    WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                                    AND vl.EntryDate BETWEEN 
                                                        sol.H2_Pu_TimeStamp 
                                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                                )
                                            )
                                        ) = 0
                                    ) 
                                    THEN 1 
                                    ELSE
                                    (
                                        (
                                            SELECT COUNT(vl.Temperature)
                                            FROM VehicleLog vl
                                            JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                            WHERE sol.Otw_AB_Vehicle = v.LicensePlate 
                                            AND vl.EntryDate BETWEEN 
                                                IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                                AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                        ) +
                                        (
                                            SELECT COUNT(vl.Temperature)
                                            FROM VehicleLog vl
                                            JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                            WHERE sol.Otw_HH_Vehicle = v.LicensePlate 
                                            AND vl.EntryDate BETWEEN sol.H1_Pu_TimeStamp AND sol.H2_Do_TimeStamp
                                        ) +
                                        (
                                            SELECT COUNT(vl.Temperature)
                                            FROM VehicleLog vl
                                            JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                            WHERE sol.Otw_AH_Vehicle = v.LicensePlate 
                                            AND vl.EntryDate BETWEEN 
                                                IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                                AND sol.H1_Do_TimeStamp
                                        ) +
                                        (
                                            SELECT COUNT(vl.Temperature)
                                            FROM VehicleLog vl
                                            JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                            WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                            AND vl.EntryDate BETWEEN 
                                                sol.H1_Pu_TimeStamp 
                                                AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                        ) +
                                        (
                                            SELECT COUNT(vl.Temperature)
                                            FROM VehicleLog vl
                                            JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                            WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                            AND vl.EntryDate BETWEEN 
                                                sol.H2_Pu_TimeStamp 
                                                AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                        )
                                    )
                                END
                            )
                        )
                        * 100
                    )
                    , 0
                ) 
                AS VARCHAR
            ) + '%'
        )
    ) AS 'Meetingen 15-25',
    (
        IIF(
            (
                (
                    (
                        SELECT COUNT(vl.Temperature)
                        FROM VehicleLog vl
                        JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                        WHERE sol.Otw_AB_Vehicle = v.LicensePlate 
                        AND vl.EntryDate BETWEEN 
                            IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                            AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                        AND vl.Temperature >= 25 AND vl.Temperature < 27
                    ) +
                    (
                        SELECT COUNT(vl.Temperature)
                        FROM VehicleLog vl
                        JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                        WHERE sol.Otw_HH_Vehicle = v.LicensePlate 
                        AND vl.EntryDate BETWEEN sol.H1_Pu_TimeStamp AND sol.H2_Do_TimeStamp
                        AND vl.Temperature >= 25 AND vl.Temperature < 27
                    ) +
                    (
                        SELECT COUNT(vl.Temperature)
                        FROM VehicleLog vl
                        JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                        WHERE sol.Otw_AH_Vehicle = v.LicensePlate 
                        AND vl.EntryDate BETWEEN 
                            IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                            AND sol.H1_Do_TimeStamp
                        AND vl.Temperature >= 25 AND vl.Temperature < 27
                    ) +
                    (
                        SELECT COUNT(vl.Temperature)
                        FROM VehicleLog vl
                        JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                        WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                        AND vl.EntryDate BETWEEN 
                            sol.H1_Pu_TimeStamp 
                            AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                        AND vl.Temperature >= 25 AND vl.Temperature < 27
                    ) +
                    (
                        SELECT COUNT(vl.Temperature)
                        FROM VehicleLog vl
                        JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                        WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                        AND vl.EntryDate BETWEEN 
                            sol.H2_Pu_TimeStamp 
                            AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                        AND vl.Temperature >= 25 AND vl.Temperature < 27
                    )
                )
                = 0), NULL, CAST(
                ROUND(
                    (
                        (
                            (
                                (
                                    SELECT COUNT(vl.Temperature)
                                    FROM VehicleLog vl
                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                    WHERE sol.Otw_AB_Vehicle = v.LicensePlate 
                                    AND vl.EntryDate BETWEEN 
                                        IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                    AND vl.Temperature >= 25 AND vl.Temperature < 27
                                ) +
                                (
                                    SELECT COUNT(vl.Temperature)
                                    FROM VehicleLog vl
                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                    WHERE sol.Otw_HH_Vehicle = v.LicensePlate 
                                    AND vl.EntryDate BETWEEN sol.H1_Pu_TimeStamp AND sol.H2_Do_TimeStamp
                                    AND vl.Temperature >= 25 AND vl.Temperature < 27
                                ) +
                                (
                                    SELECT COUNT(vl.Temperature)
                                    FROM VehicleLog vl
                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                    WHERE sol.Otw_AH_Vehicle = v.LicensePlate 
                                    AND vl.EntryDate BETWEEN 
                                        IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                        AND sol.H1_Do_TimeStamp
                                    AND vl.Temperature >= 25 AND vl.Temperature < 27
                                ) +
                                (
                                    SELECT COUNT(vl.Temperature)
                                    FROM VehicleLog vl
                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                    WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                    AND vl.EntryDate BETWEEN 
                                        sol.H1_Pu_TimeStamp 
                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                    AND vl.Temperature >= 25 AND vl.Temperature < 27
                                ) +
                                (
                                    SELECT COUNT(vl.Temperature)
                                    FROM VehicleLog vl
                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                    WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                    AND vl.EntryDate BETWEEN 
                                        sol.H2_Pu_TimeStamp 
                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                    AND vl.Temperature >= 25 AND vl.Temperature < 27
                                )
                            )
                            /
                            (
                                CASE 
                                    WHEN 
                                    (
                                        (
                                            (
                                                (
                                                    SELECT COUNT(vl.Temperature)
                                                    FROM VehicleLog vl
                                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                                    WHERE sol.Otw_AB_Vehicle = v.LicensePlate 
                                                    AND vl.EntryDate BETWEEN 
                                                        IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                                ) +
                                                (
                                                    SELECT COUNT(vl.Temperature)
                                                    FROM VehicleLog vl
                                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                                    WHERE sol.Otw_HH_Vehicle = v.LicensePlate 
                                                    AND vl.EntryDate BETWEEN sol.H1_Pu_TimeStamp AND sol.H2_Do_TimeStamp
                                                ) +
                                                (
                                                    SELECT COUNT(vl.Temperature)
                                                    FROM VehicleLog vl
                                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                                    WHERE sol.Otw_AH_Vehicle = v.LicensePlate 
                                                    AND vl.EntryDate BETWEEN 
                                                        IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                                        AND sol.H1_Do_TimeStamp
                                                ) +
                                                (
                                                    SELECT COUNT(vl.Temperature)
                                                    FROM VehicleLog vl
                                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                                    WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                                    AND vl.EntryDate BETWEEN 
                                                        sol.H1_Pu_TimeStamp 
                                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                                ) +
                                                (
                                                    SELECT COUNT(vl.Temperature)
                                                    FROM VehicleLog vl
                                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                                    WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                                    AND vl.EntryDate BETWEEN 
                                                        sol.H2_Pu_TimeStamp 
                                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                                )
                                            )
                                        ) = 0
                                    ) 
                                    THEN 1 
                                    ELSE
                                    (
                                        (
                                            SELECT COUNT(vl.Temperature)
                                            FROM VehicleLog vl
                                            JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                            WHERE sol.Otw_AB_Vehicle = v.LicensePlate 
                                            AND vl.EntryDate BETWEEN 
                                                IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                                AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                        ) +
                                        (
                                            SELECT COUNT(vl.Temperature)
                                            FROM VehicleLog vl
                                            JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                            WHERE sol.Otw_HH_Vehicle = v.LicensePlate 
                                            AND vl.EntryDate BETWEEN sol.H1_Pu_TimeStamp AND sol.H2_Do_TimeStamp
                                        ) +
                                        (
                                            SELECT COUNT(vl.Temperature)
                                            FROM VehicleLog vl
                                            JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                            WHERE sol.Otw_AH_Vehicle = v.LicensePlate 
                                            AND vl.EntryDate BETWEEN 
                                                IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                                AND sol.H1_Do_TimeStamp
                                        ) +
                                        (
                                            SELECT COUNT(vl.Temperature)
                                            FROM VehicleLog vl
                                            JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                            WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                            AND vl.EntryDate BETWEEN 
                                                sol.H1_Pu_TimeStamp 
                                                AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                        ) +
                                        (
                                            SELECT COUNT(vl.Temperature)
                                            FROM VehicleLog vl
                                            JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                            WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                            AND vl.EntryDate BETWEEN 
                                                sol.H2_Pu_TimeStamp 
                                                AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                        )
                                    )
                                END
                            )
                        )
                        * 100
                    )
                    , 0
                ) 
                AS VARCHAR
            ) + '%'
        )   
    ) AS 'Meetingen 25-27',
    (
        IIF(
            (
                (
                    (
                        SELECT COUNT(vl.Temperature)
                        FROM VehicleLog vl
                        JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                        WHERE sol.Otw_AB_Vehicle = v.LicensePlate 
                        AND vl.EntryDate BETWEEN 
                            IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                            AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                        AND vl.Temperature >= 27
                    ) +
                    (
                        SELECT COUNT(vl.Temperature)
                        FROM VehicleLog vl
                        JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                        WHERE sol.Otw_HH_Vehicle = v.LicensePlate 
                        AND vl.EntryDate BETWEEN sol.H1_Pu_TimeStamp AND sol.H2_Do_TimeStamp
                        AND vl.Temperature >= 27
                    ) +
                    (
                        SELECT COUNT(vl.Temperature)
                        FROM VehicleLog vl
                        JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                        WHERE sol.Otw_AH_Vehicle = v.LicensePlate 
                        AND vl.EntryDate BETWEEN 
                            IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                            AND sol.H1_Do_TimeStamp
                        AND vl.Temperature >= 27
                    ) +
                    (
                        SELECT COUNT(vl.Temperature)
                        FROM VehicleLog vl
                        JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                        WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                        AND vl.EntryDate BETWEEN 
                            sol.H1_Pu_TimeStamp 
                            AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                        AND vl.Temperature >= 27
                    ) +
                    (
                        SELECT COUNT(vl.Temperature)
                        FROM VehicleLog vl
                        JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                        WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                        AND vl.EntryDate BETWEEN 
                            sol.H2_Pu_TimeStamp 
                            AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                        AND vl.Temperature >= 27
                    )
                )
                = 0), NULL, CAST(
                ROUND(
                    (
                        (
                            (
                                (
                                    SELECT COUNT(vl.Temperature)
                                    FROM VehicleLog vl
                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                    WHERE sol.Otw_AB_Vehicle = v.LicensePlate 
                                    AND vl.EntryDate BETWEEN 
                                        IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                    AND vl.Temperature >= 27
                                ) +
                                (
                                    SELECT COUNT(vl.Temperature)
                                    FROM VehicleLog vl
                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                    WHERE sol.Otw_HH_Vehicle = v.LicensePlate 
                                    AND vl.EntryDate BETWEEN sol.H1_Pu_TimeStamp AND sol.H2_Do_TimeStamp
                                    AND vl.Temperature >= 27
                                ) +
                                (
                                    SELECT COUNT(vl.Temperature)
                                    FROM VehicleLog vl
                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                    WHERE sol.Otw_AH_Vehicle = v.LicensePlate 
                                    AND vl.EntryDate BETWEEN 
                                        IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                        AND sol.H1_Do_TimeStamp
                                    AND vl.Temperature >= 27
                                ) +
                                (
                                    SELECT COUNT(vl.Temperature)
                                    FROM VehicleLog vl
                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                    WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                    AND vl.EntryDate BETWEEN 
                                        sol.H1_Pu_TimeStamp 
                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                    AND vl.Temperature >= 27
                                ) +
                                (
                                    SELECT COUNT(vl.Temperature)
                                    FROM VehicleLog vl
                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                    WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                    AND vl.EntryDate BETWEEN 
                                        sol.H2_Pu_TimeStamp 
                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                    AND vl.Temperature >= 27
                                )
                            )
                            /
                            (
                                CASE 
                                    WHEN 
                                    (
                                        (
                                            (
                                                (
                                                    SELECT COUNT(vl.Temperature)
                                                    FROM VehicleLog vl
                                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                                    WHERE sol.Otw_AB_Vehicle = v.LicensePlate 
                                                    AND vl.EntryDate BETWEEN 
                                                        IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                                ) +
                                                (
                                                    SELECT COUNT(vl.Temperature)
                                                    FROM VehicleLog vl
                                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                                    WHERE sol.Otw_HH_Vehicle = v.LicensePlate 
                                                    AND vl.EntryDate BETWEEN sol.H1_Pu_TimeStamp AND sol.H2_Do_TimeStamp
                                                ) +
                                                (
                                                    SELECT COUNT(vl.Temperature)
                                                    FROM VehicleLog vl
                                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                                    WHERE sol.Otw_AH_Vehicle = v.LicensePlate 
                                                    AND vl.EntryDate BETWEEN 
                                                        IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                                        AND sol.H1_Do_TimeStamp
                                                ) +
                                                (
                                                    SELECT COUNT(vl.Temperature)
                                                    FROM VehicleLog vl
                                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                                    WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                                    AND vl.EntryDate BETWEEN 
                                                        sol.H1_Pu_TimeStamp 
                                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                                ) +
                                                (
                                                    SELECT COUNT(vl.Temperature)
                                                    FROM VehicleLog vl
                                                    JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                                    WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                                    AND vl.EntryDate BETWEEN 
                                                        sol.H2_Pu_TimeStamp 
                                                        AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                                )
                                            )
                                        ) = 0
                                    ) 
                                    THEN 1 
                                    ELSE
                                    (
                                        (
                                            SELECT COUNT(vl.Temperature)
                                            FROM VehicleLog vl
                                            JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                            WHERE sol.Otw_AB_Vehicle = v.LicensePlate 
                                            AND vl.EntryDate BETWEEN 
                                                IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                                AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                        ) +
                                        (
                                            SELECT COUNT(vl.Temperature)
                                            FROM VehicleLog vl
                                            JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                            WHERE sol.Otw_HH_Vehicle = v.LicensePlate 
                                            AND vl.EntryDate BETWEEN sol.H1_Pu_TimeStamp AND sol.H2_Do_TimeStamp
                                        ) +
                                        (
                                            SELECT COUNT(vl.Temperature)
                                            FROM VehicleLog vl
                                            JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                            WHERE sol.Otw_AH_Vehicle = v.LicensePlate 
                                            AND vl.EntryDate BETWEEN 
                                                IIF(sol.Pu_StopReceive_TimeStamp IS NULL, so.PlannedPickup_Timestamp, sol.Pu_StopReceive_TimeStamp) 
                                                AND sol.H1_Do_TimeStamp
                                        ) +
                                        (
                                            SELECT COUNT(vl.Temperature)
                                            FROM VehicleLog vl
                                            JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                            WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                            AND vl.EntryDate BETWEEN 
                                                sol.H1_Pu_TimeStamp 
                                                AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                        ) +
                                        (
                                            SELECT COUNT(vl.Temperature)
                                            FROM VehicleLog vl
                                            JOIN Vehicle v ON vl.VehicleId = v.VehicleId
                                            WHERE sol.Otw_HB_Vehicle = v.LicensePlate 
                                            AND vl.EntryDate BETWEEN 
                                                sol.H2_Pu_TimeStamp 
                                                AND IIF(sol.Do_StopDeliver_TimeStamp IS NULL, so.PlannedDropoff_Timestamp,sol.Do_StopDeliver_TimeStamp)
                                        )
                                    )
                                END
                            )
                        )
                        * 100
                    )
                    , 0
                ) 
                AS VARCHAR
            ) + '%'
        )
    ) AS 'Meetingen >27',    

    so.SalesOrderId AS OrderNumber
    ,
    t.Code AS Transporttype,
    o1.Name AS Naam,
    a.Description AS Verpakking,
    so.Description AS Omschrijving,
    (LEN(so.InternalUnits) - LEN(replace(so.InternalUnits, ',','')) +1) AS AantalEenheden,
    ic.Description AS InterneConditionering,
    so.Barcode AS InterneBarcodes,
    -- Vertrek
        o1.Name AS VertrekOrganisatie,
        d1.Name AS VertrekAfdeling,
        s1.Name AS VertrekStopplaats,
        a1.Street AS VertekStraat,
        a1.HouseNumber AS VertrekHuisnummer,
        a1.PostalCode AS VertrekPostcode,
        a1.City AS VertrekGemeente,
    -- Bestemming
        o2.Name AS BestemmingOrganisatie,
        d2.Name AS BestemmingAfdeling,
        s2.Name AS BestemmingStopplaats,
        a2.Street AS BestemmingStraat,
        a2.HouseNumber AS BestemmingHuisnummer,
        a2.PostalCode AS BestemmingPostcode,
        a2.City AS BestemmingGemeente,
    -- Timestamps
        so.PlannedPickup_Timestamp AS PlannedPickup,
        sol.Pu_StopReceive_TimeStamp AS RealizedPickup,
        so.PlannedDropoff_Timestamp AS PlannedDropoff,
        sol.Do_StopDeliver_TimeStamp AS RealizedDropoff,
        sol.H1_Do_TimeStamp AS DropoffTimeH1,
        sol.H2_Do_TimeStamp AS DropoffTimeH2,
        sol.H1_Pu_TimeStamp AS PickupTimeH1,
        sol.H2_Pu_TimeStamp AS PickupTimeH2,
    so.Packaging_Barcode AS BarcodeVerpakking,
    sor.Remark_Main AS Opmerking,
    sor.Remark_FreeTextLabel AS VrijeTeksLabel,
    sor.Remark_FreeTextContent AS VrijeTekstInhoud,
    u.Email AS OrderAangemaaktDoor,
    sol.Pu_StopReceive_PersName AS TEBijPickupOntvangenVanPersoon,
    sol.Do_StopDeliver_PersName AS TEBijDropoffAfgegevenAanPersoon

FROM SalesOrder so
    INNER JOIN TransportType t ON so.TransportTypeId=t.TransportTypeId
    LEFT JOIN SalesOrderLog sol ON so.SalesOrder_LogId=sol.SalesOrderLogId
    LEFT JOIN SalesOrderRemark sor ON so.SalesOrder_RemarkId=sor.SalesOrderRemarkId
    INNER JOIN [dbo].[User] u ON so.Created_userId=u.UserId
    INNER JOIN InternalConditioning ic ON so.InternalConditioningId=ic.InternalConditioningId
    INNER JOIN Article a ON so.ArticleId=a.ArticleId
    --Departure
        INNER JOIN DepartureDepartment dpd ON so.DepartureDepartmentId=dpd.DepartureDepartmentId
        INNER JOIN Department d1 ON dpd.DepartmentId=d1.DepartmentId
        INNER JOIN OrganizatiON o1 ON dpd.OrganizationId=o1.OrganizationId
        INNER JOIN Stopplace s1 ON d1.StopplaceId=s1.StopplaceId
        INNER JOIN Address a1 ON s1.AddressId=a1.AddressId
    --Destination
        INNER JOIN DestinationDepartment dsd ON so.DestinationDepartmentId=dsd.DestinationDepartmentId
        INNER JOIN Department d2 ON dsd.DepartmentId=d2.DepartmentId
        INNER JOIN Organization o2 ON dsd.OrganizationId=o2.OrganizationId
        INNER JOIN Stopplace s2 ON d2.StopplaceId=s2.StopplaceId
        INNER JOIN Address a2 ON s2.AddressId=a2.AddressId

WHERE 
    so.OrderDate LIKE @Jaar
    AND
    d1.Name LIKE @VertrekDepartment
    AND
    o1.Name LIKE @VertrekOrganisatie


ORDER BY so.SalesOrderId